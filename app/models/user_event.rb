require 'json'
class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event
  before_save :user_likes

  def user_likes
    u = User.find(user_id)
    e = Event.find(event_id)
    u.likes[e.cause] += 1
    u.save
    # hash = u.likes.dup
    # u.update(likes: hash)
    p u.likes
  end
end
