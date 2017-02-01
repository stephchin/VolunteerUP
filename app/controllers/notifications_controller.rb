class NotificationsController < ApplicationController
  protect_from_forgery with: :exception
  skip_authorize_resource only: [:index]

  def index
    @notifications = Notification.all.reverse
  end



end
