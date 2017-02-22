class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_ability
  before_action :authenticate_user!, except: [:index, :show, :map_location, :map_locations, :remove_event]
  load_and_authorize_resource
  skip_authorize_resource only: [:map_location, :map_locations]

  # GET /events
  # GET /events.json

  def index

    # @events = Event.all.where("end_time >= ?", Time.now)
    # Initialize filterrific with the following params:
    @filterrific = initialize_filterrific(
      Event,
      params[:filterrific],
      select_options: {
        sorted_by: Event.options_for_sorted_by
      },
      persistence_id: false,
    ) or return

    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
    end

    # kaminari pagination
    # @events = @events.page(params[:page]).per(5)

    if !params[:filterrific].nil?
      @zip = params[:filterrific][:with_distance][:zip]
      @max_distance = params[:filterrific][:with_distance][:max_distance]
      @search = params[:filterrific][:search_query]

      if @zip.empty? || @max_distance.empty?
        @events = @filterrific.find.page(params[:page])
      else
        @events = @filterrific.find.near(@zip, @max_distance).page(params[:page])
      end
    end
    # kaminari pagination

    @events = @events.where("end_time >= ?", Time.now)


    @events = @events.page(params[:page]).per(5)
    @current_page = @events.page(params[:page]).per(5).current_page

  # Recover from invalid param sets, e.g., when a filter refers to the
  # database id of a record that doesn’t exist any more.
  # In this case we reset filterrific and discard all filter params.
  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return
  end


  # GET /events/1
  # GET /events/1.json
  def show
    # @ability = Ability.new(current_user)
  end


  # GMAPS Functions
  def map_location
    @event = Event.find(params[:event_id])
    @hash = Gmaps4rails.build_markers(@event) do |event, marker|
      marker.lat(event.latitude)
      marker.lng(event.longitude)
      marker.infowindow("<div style='font-weight: bold;'>#{event.name}</div>#{event.organization.name}<br><br>#{event.street}<br>#{event.city}, #{event.state} #{event.postal_code}")
    end
    render json: @hash.to_json
  end

  def map_locations
    @events = Event.all.where("end_time >= ?", Time.now)

    @filterrific = initialize_filterrific(
      Event,
      params[:filterrific],
      select_options: {
        sorted_by: Event.options_for_sorted_by
      },
      persistence_id: false,
    ) or return

    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
    end

    if !params[:filterrific].nil?
      @zip = params[:filterrific][:with_distance][:zip]
      @max_distance = params[:filterrific][:with_distance][:max_distance]

      if @zip.empty? || @max_distance.empty?
        @events = @filterrific.find.page(params[:page]).per(5)
      else
        @events = @filterrific.find.near(@zip, @max_distance).page(params[:page]).per(5)
      end
    else
      @events = @events.page(params[:page]).per(5)
    end

    @hash = Gmaps4rails.build_markers(@events) do |event,marker|
      marker.lat(event.latitude)
      marker.lng(event.longitude)
      marker.infowindow("<div style='font-weight: bold;'>#{event.name}</div>#{event.organization.name}<br><br>#{event.street}<br>#{event.city}, #{event.state} #{event.postal_code}")
    end
    render json: @hash.to_json
  end


  # GET /events/new
  def new
    @event = Event.new

    @organizations_for_select = Organization.joins(:user_organizations).where(user_organizations: {user_id: current_user.id}).map do |org|
      [org.name, org.id]
    end

  end

  # GET /events/1/edit
  def edit
    @organizations_for_select = Organization.joins(:user_organizations).where(user_organizations: {user_id: current_user.id}).map do |org|
      [org.name, org.id]
    end
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    @organizations_for_select = Organization.joins(:user_organizations).where(user_organizations: {user_id: current_user.id}).map do |org|
      [org.name, org.id]
    end

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "#{@event.name} was successfully created!" }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @organizations_for_select = Organization.all.map do |org|
      [org.name, org.id]
    end

    respond_to do |format|
      if @event.update(event_params)
        add_notification("has been updated!")
        format.html { redirect_to @event, notice: "#{@event.name} was successfully updated!" }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    add_notification("has been cancelled.")
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Your event was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def add_user
    event = Event.find(params[:event_id])
    if !user_signed_in?
      redirect_to new_user_session_path
    elsif !event.users.all.include?(current_user) && event.remaining_vol > 0
      event.user_events.new(user: current_user)
      event.save
      flash[:success] = "You're signed up! Happy volunteering."
      redirect_to event_path(event.id)
    elsif event.remaining_vol <= 0
      waitlist_number = event.user_events.maximum("waitlist");
      if waitlist_number.nil?
        waitlist_number = 1
      end
      flash[:notice] = "You've been added to the waitlist!"
      event.user_events.new(user: current_user, waitlist: waitlist_number + 1)
      event.save
      redirect_to event_path(event.id)
    end
  end

  def remove_event
    u1 = User.find(current_user.id)
    e1 = Event.find(params[:event])
    u1.user_events.delete(event: e1)
    u1.events.delete(e1)
    flash[:alert] = "You've cancelled your RSVP for #{e1.name}."
    event_waitlist = e1.user_events.where.not(waitlist: nil)
    if event_waitlist.length > 0
      event_waitlist.sort
      event_waitlist[0].waitlist = nil
      Notification.create(event: "You've been added to the event!", user_id: event_waitlist[0].user_id)
      event_waitlist[0].save
    end
    redirect_to user_path(u1)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  def set_ability
    @ability = Ability.new(current_user)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:name, :description, :cause, :start_time, :end_time, :street, :city, :state, :postal_code, :country, :volunteers_needed, :organization_id)
  end

  def add_notification(str)
    @event.users.all.each do |user|
      Notification.create(event: "#{@event.name} #{str}", user_id: user.id)
    end
  end

end
