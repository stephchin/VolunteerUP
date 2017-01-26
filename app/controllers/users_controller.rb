class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @events = @user.events.all
  end

  def remove_event
    u1 = User.find(params[:user_id])
    e1 = Event.find(params[:event])
    u1.user_events.delete(event: e1)
    u1.events.delete(e1)
    redirect_to user_path(u1)
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


  private

    #Use callbacks to share common setup or constraints between actions
    def set_user
      @user = User.find(params[:id])
    end

end
