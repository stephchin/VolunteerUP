class User < ApplicationRecord
  # after_create :assign_role

  rolify
  #if a user is destroyed, this destroys the link between user and event, but not the actual event
  has_many :user_events, :dependent => :destroy
  has_many :events, through: :user_events
  has_many :user_organizations
  has_many :organizations, through: :user_organizations
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true

  # def assign_role
  #   add_role(:student)
  # end

end
