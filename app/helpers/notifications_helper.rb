module NotificationsHelper

  def add_user_notification(msg, user)
    Notification.create(event: msg, user_id: user.id)
  end

  def organizer_left_notification(user, org)
    Notification.create(
      event: "#{user.name} has left #{org.name}",
      user_id: organizer.user_id
    )
  end

  def organizer_removed_notification(user, org, organizer)
    Notification.create(
      event: "#{user.name} has been removed from - #{org.name}",
      user_id: organizer.user_id
    )
  end

  def removed_organizer_notification(user, org)
    Notification.create(
      event: "You've been removed from #{org.name}", user_id: user.id
    )
  end

  def removed_self_notification(user, org)
    Notification.create(
      event: "You've left #{org.name}", user_id: current_user.id
    )
  end

end
