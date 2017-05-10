module MessagesHelper
  include NotificationsHelper

  def add_user_success_msg(org, user)
    msg = "You are now an organizer for #{org.name}!"
    flash[:notice] = msg
    add_user_notification(msg, user)
  end

  def removed_organizer_success_msg(user, org)
    flash[:alert] = "You've successfully removed #{user.name} from #{org.name}."
    removed_organizer_notification(user, org)
  end

  def removed_self_success_msg(user, org)
    flash[:alert] = "You've left #{org.name}."
    removed_self_notification(user, org)
  end
end
