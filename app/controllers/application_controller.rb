class ApplicationController < ActionController::Base
  before_action :set_notification
  add_flash_types :success, :remove



  protected

  def set_notification
    if Notification.all.nil?  || !user_signed_in?
      @notifications = []
    else
      @notifications = current_user.notifications.all.reverse
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :city, :state, :image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:image])
  end

end
