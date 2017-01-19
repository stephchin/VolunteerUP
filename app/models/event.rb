class Event < ApplicationRecord
  has_many :user_events
  has_many :users, through: :user_events

  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :volunteers_needed, presence: true

  def address
    "#{street}, #{city} #{state} #{postal_code}"
  end
end
