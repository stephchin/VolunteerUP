class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_ability
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource

  # GET /events
  # GET /events.json
  #def index
    # if params[:search].present?
    #   #uses fuzzy search for all event string fields
    #   @search_events = Event.fuzzy_search(params[:search])
    #   #joins org table and uses fuzzy search on just the name
    #   @search_orgs = Event.joins(:organization).fuzzy_search(organizations: {name: params[:search]})
    #   s_year = params[:start_time][:year].to_i
    #   s_month = params[:start_time][:month].to_i
    #   s_day = params[:start_time][:day].to_i
    #   s_time = DateTime.new(s_year, s_month, s_day)
    #   @on = Event.all.where("start_time >= ?", s_time.beginning_of_day)
    #   #union of both searches which updates the index
    #   @search = (@search_events | @search_orgs) & @on
    # else
    #   @search = Event.all
    # end
    # if !params[:end_time].nil? && (!params[:end_time][:year].empty? &&
    #   !params[:end_time][:month].empty? && !params[:end_time][:day].empty?)
    #   s_year = params[:start_time][:year].to_i
    #   s_month = params[:start_time][:month].to_i
    #   s_day = params[:start_time][:day].to_i
    #   e_year = params[:end_time][:year].to_i
    #   e_month = params[:end_time][:month].to_i
    #   e_day = params[:end_time][:day].to_i
    #   s_time = DateTime.new(s_year, s_month, s_day)
    #   e_time = DateTime.new(e_year, e_month, e_day)
    #   @date = Event.all.where(start_time: s_time.beginning_of_day..e_time.end_of_day)
    # else
    #   @date = Event.all
    # end
    # @events = @search & @date
    # @events.sort! do |x, y|
    #   x.start_time <=> y.start_time
    # end
  #end

  def index

    # Initialize filterrific with the following params:
    # * `Student` is the ActiveRecord based model class.
    # * `params[:filterrific]` are any params submitted via web request.
    #   If they are blank, filterrific will try params persisted in the session
    #   next. If those are blank, too, filterrific will use the model's default
    #   filter settings.
    # * Options:
    #     * select_options: You can store any options for `<select>` inputs in
    #       the filterrific form here. In this example, the `#options_for_...`
    #       methods return arrays that can be passed as options to `f.select`
    #       These methods are defined in the model.
    #     * persistence_id: optional, defaults to "<controller>#<action>" string
    #       to isolate session persistence of multiple filterrific instances.
    #       Override this to share session persisted filter params between
    #       multiple filterrific instances. Set to `false` to disable session
    #       persistence.
    #     * default_filter_params: optional, to override model defaults
    #     * available_filters: optional, to further restrict which filters are
    #       in this filterrific instance.
    # This method also persists the params in the session and handles resetting
    # the filterrific params.
    # In order for reset_filterrific to work, it's important that you add the
    # `or return` bit after the call to `initialize_filterrific`. Otherwise the
    # redirect will not work.
    @filterrific = initialize_filterrific(
      Event,
      params[:filterrific],
      select_options: {
        sorted_by: Event.options_for_sorted_by
      },
      persistence_id: false
    ) or return
    # Get an ActiveRecord::Relation for all students that match the filter settings.
    # You can paginate with will_paginate or kaminari.
    # NOTE: filterrific_find returns an ActiveRecord Relation that can be
    # chained with other scopes to further narrow down the scope of the list,
    # e.g., to apply permissions or to hard coded exclude certain types of records.
    @events = @filterrific.find.page(params[:page])

    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
    end

  # Recover from invalid param sets, e.g., when a filter refers to the
  # database id of a record that doesn’t exist any more.
  # In this case we reset filterrific and discard all filter params.
  rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Had to reset filterrific params: #{ e.message }"
    redirect_to(reset_filterrific_url(format: :html)) and return

    # kaminari pagination
    @events = @events.page(params[:page]).per(5)
    
  end


  # GET /events/1
  # GET /events/1.json
  def show
    # @ability = Ability.new(current_user)
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
