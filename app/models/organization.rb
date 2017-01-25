class Organization < ApplicationRecord
  has_many :events, dependent: :destroy

  #if an org is destroyed, this destroys the link between user and orgs, but not the actual user
  has_many :user_organizations, :dependent => :destroy
  has_many :users, through: :user_organizations

  validates :name, uniqueness: true, presence: true
  validates :description, presence: true

  resourcify

end
