class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  # load_and_authorize_resource

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
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
    elsif !event.users.all.include?(current_user)
      event.user_events.new(user: current_user)
      event.save
      redirect_to user_path(current_user.id)
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :cause, :start_time, :end_time, :street, :city, :state, :postal_code, :country, :volunteers_needed, :organization_id)
    end
end
