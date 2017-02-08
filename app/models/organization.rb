class Organization < ApplicationRecord
  has_many :events, dependent: :destroy
  #if an org is destroyed, this destroys the link between user and orgs, but not the actual user
  has_many :user_organizations, :dependent => :destroy
  has_many :users, through: :user_organizations

  validates :name, uniqueness: true, presence: true
  validates :description, presence: true

  has_attached_file :image, styles: { small: "64x64", med: "250x250", large: "400x400" }, s3_protocol: :https, default_url: "default_org.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  resourcify

end
