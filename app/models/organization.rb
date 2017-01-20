class Organization < ApplicationRecord
  has_many :events
  has_many :users, through: :user_organizations
  has_many :user_organizations

  validates :name, uniqueness: true, presence: true
  validates :description, presence: true
end
