class Message < ApplicationRecord
  after_create_commit { notify }
  belongs_to :user

  private

  def notify
    Notification.create(event: "New Notification (#{self.body})")
  end
end
