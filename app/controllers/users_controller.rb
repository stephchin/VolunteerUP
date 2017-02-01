class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_ability
  before_action :authenticate_user!, except: [:index, :show, :user_map_locations]
  load_and_authorize_resource
  skip_authorize_resource only: [:get_events, :user_map_locations]


  def show
    @events = @user.events.all
    if user_signed_in?
      @causes = current_user.likes.sort_by{ |key, value| -value }.select{ |cause| (Event.where(cause: cause[0]).map(&:id) - current_user.events.all.map(&:id)).length > 0 }.first(3)
      @cause_list = []
      @causes.each do |cause|
        a = Event.where(cause: cause[0]).map(&:id) - current_user.events.all.map(&:id)
        @cause_list << Event.find(a[0])
      end
    else
      @causes = []
    end
  end

  def user_map_locations
    # @user_events = User.find(1).events
    @user_events = current_user.events

    @hash = Gmaps4rails.build_markers(@user_events) do |event,marker|
      marker.lat(event.latitude)
      marker.lng(event.longitude)
      marker.infowindow("<p style='text-align: center;'>#{event.name}</p>Hosted By:  #{event.organization.name}")
    end
    render json: @hash.to_json
  end

  # GET all events for calendar on user profile
 def get_events
   user_events = User.find(params[:user_id]).events
   calendar_events = []
   user_events.each do |event|
     calendar_events << {
      id: event.id,
      title: event.name,
      start: event.start_time,
      end: event.end_time,
      url: '/events/' + event.id.to_s
      # create url so you can click on a specific event and be taken to that page
     }
   end
   render :json => calendar_events.to_json
 end

  private

    #Use callbacks to share common setup or constraints between actions
    def set_user
      @user = User.find(params[:id])
    end

    def set_ability
      @ability = Ability.new(current_user)
    end

end
