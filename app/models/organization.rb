class Organization < ApplicationRecord
  has_many :events

  validates :name, uniqueness: true, presence: true
  validates :description, presence: true

  resourcify
end
