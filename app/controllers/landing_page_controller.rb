class LandingPageController < ApplicationController

  def index
    if user_signed_in?
      redirect_to user_path(current_user)
    else
      @organizations = Organization.all
      @events = Event.all
      @users = User.all
      @locations = Event.all
    end
  end

  def about
  end

end
