class Notification < ApplicationRecord
  belongs_to :user
  after_create_commit  { NotificationBroadcastJob.perform_later(Notification.count,self)}
end
