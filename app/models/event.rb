class Event < ApplicationRecord
  #if an event is destroyed, this destroys the link between event and user, but not the actual user
  has_many :user_events, :dependent => :destroy
  has_many :users, through: :user_events

  belongs_to :organization

  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :volunteers_needed, presence: true
  validates :organization, presence:true

  geocoded_by :address
  after_validation :geocode

  def address
    "#{street}, #{city} #{state} #{postal_code}"
  end

  def remaining_vol
    volunteers_needed - self.users.count
  end

  resourcify
end
