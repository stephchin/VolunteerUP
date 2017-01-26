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
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:twitter, :facebook]
  validates :name, presence: true

  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }, default_url: "default_user.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def assign_role
    add_role(:volunteer) if self.roles.blank?
  end

  def self.from_omniauth(auth)
    if auth.provider == "facebook"
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
        # user.city = auth.info.first_name
        # user.state = auth.info.last_name
      end
    elsif auth.provider == "twitter"
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.nickname + "@twitter.com"
        user.password = Devise.friendly_token[0,20]
        user.name = auth.info.name
        location = auth.info.location.split(", ")
        user.city = location[0]
        user.state = location[1]
      end
    end
  end

  rolify
end
