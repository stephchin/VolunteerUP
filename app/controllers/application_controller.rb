class ApplicationController < ActionController::Base
  include UsersHelper
  include EventsHelper
  include NotificationsHelper
  include MessagesHelper

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_notification
  # before_action :delete_notification
  #adding
  # protect_from_forgery with: :exception
  add_flash_types :success, :remove

  # This method deletes notifications when you click the "X",
  # without refreshing the page
  def delete_notification
    notification = Notification.find(params[:notif_id])
    notification.delete
  end

  protected


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: [:name, :city, :state, :image]
    )
    devise_parameter_sanitizer.permit(
      :account_update, keys: [:name, :city, :state, :image]
    )
  end

  def set_notification
    if Notification.all.nil?  || !user_signed_in?
      @notifications = []
    else
      @notifications = current_user.notifications.all.reverse
    end
  end
end
