class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_ability
  before_action :authenticate_user!, except: [:index, :show, :map_location, :map_locations]
  load_and_authorize_resource
  skip_authorize_resource only: [:map_location, :map_locations]



  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    # @ability = Ability.new(current_user)
    if params[:search].present?
      #uses fuzzy search for all event string fields
      @search_events = Event.fuzzy_search(params[:search])
      #joins org table and uses fuzzy search on just the name
      @search_orgs = Event.joins(:organization).fuzzy_search(organizations: {name: params[:search]})
      #union of both searches which updates the index
      @events = @search_events | @search_orgs
    end
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
      marker.infowindow("<p style='text-align: center;'>#{event.name}</p>Hosted By:  #{event.organization.name}")
    end
    render json: @hash.to_json
  end

  def map_locations
    @events = Event.all
    if params[:search]
      @events = Event.search(params[:search])
    end

    @hash = Gmaps4rails.build_markers(@events) do |event,marker|
      marker.lat(event.latitude)
      marker.lng(event.longitude)
      marker.infowindow("<p style='text-align: center;'>#{event.name}</p>Hosted By:  #{event.organization.name}")
    end
    render json: @hash.to_json
  end


  # GET /events/new
  def new
    @event = Event.new

    @organizations_for_select = Organization.all.map do |org|
      [org.name, org.id]
    end

  end

  # GET /events/1/edit
  def edit
    @organizations_for_select = Organization.all.map do |org|
      [org.name, org.id]
    end
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    @organizations_for_select = Organization.all.map do |org|
      [org.name, org.id]
    end

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
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
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
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
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_user
    event = Event.find(params[:event_id])
    if !user_signed_in?
      flash[:notice] = "Please log in to volunteer."
      redirect_to new_user_session_path
    elsif !event.users.all.include?(current_user) && event.remaining_vol >= 1
      event.user_events.new(user: current_user)
      event.save
      redirect_to user_path(current_user.id)
    elsif event.remaining_vol <= 0
      flash[:notice] = "Sorry, this event is full."
      redirect_to event_path(event.id)
    else
      flash[:notice] = "You already signed up!"
      redirect_to event_path(event.id)
    end
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
end
