require 'json'
class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event
  before_save :user_likes

  def user_likes
    u = User.find(user_id)
    e = Event.find(event_id)
    new_val = u.likes[e.cause] += 1
    u.likes = u.likes.merge(e.cause => new_val)
    u.save
    p u.likes
  end
end
