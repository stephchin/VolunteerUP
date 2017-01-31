require 'json'
class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event
  after_create :user_likes

  def user_likes
    u = User.find(user_id)
    e = Event.find(event_id)
    u.likes[e.cause] += 1
    hash = u.likes.dup
    u.update(likes: hash)
  end
end
