class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_ability
  before_action :authenticate_user!
  load_and_authorize_resource

  def show
    @events = @user.events.all
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
