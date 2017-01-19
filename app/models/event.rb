class Event < ApplicationRecord
  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :volunteers_needed, presence: true

  def address
    "#{street}, #{city} #{state} #{postal_code}"
  end
end
