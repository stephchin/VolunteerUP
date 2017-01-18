class Organization < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  validates :description, presence: true
end
