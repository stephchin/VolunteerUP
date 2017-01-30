class AddUserToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_reference :notifications, :user, foreign_key: true
  end
end
