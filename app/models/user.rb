class User < ApplicationRecord
  has_many :user_events
  has_many :events, through: :user_events
  has_many :user_organizations
  has_many :organizations, through: :user_organizations
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true
end
