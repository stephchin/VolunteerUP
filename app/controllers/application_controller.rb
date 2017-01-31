class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_notification
  # protect_from_forgery with: :exception
  add_flash_types :success, :remove



  protected


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :city, :state, :image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:image])
  end

  def set_notification
    if Notification.all.nil?  || !user_signed_in?
      @notifications = []
    else
      @notifications = current_user.notifications.all.reverse
    end
  end

end
