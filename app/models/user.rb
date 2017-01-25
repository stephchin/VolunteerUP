class User < ApplicationRecord
  after_commit :assign_role

  #if a user is destroyed, this destroys the link between user and event, but not the actual event
  has_many :user_events, :dependent => :destroy
  has_many :events, through: :user_events

  #if a user is destroyed, this destroys the link between user and organization, but not the actual organization
  has_many :user_organizations, :dependent => :destroy
  has_many :organizations, through: :user_organizations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:twitter]
  validates :name, presence: true

  def assign_role
    add_role(:volunteer) if self.roles.blank?
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.nickname + "@twitter.com"
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
      location = auth.info.location.split(", ")
      user.city = location[0]
      user.state = location[1]
    end
  end

  rolify
end
