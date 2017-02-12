class Organization < ApplicationRecord
  has_many :events, dependent: :destroy
  #if an org is destroyed, this destroys the link between user and orgs, but not the actual user
  has_many :user_organizations, :dependent => :destroy
  has_many :users, through: :user_organizations

  validates :name, uniqueness: true, presence: true
  validates :description, presence: true

  has_attached_file :image, styles: { small: "", med: "", large: "" },
  :convert_options => {
  :small => "-resize 60x60^ -gravity Center -crop 60x60+0+0 +repage ",
  :med => "-resize 200x200^ -gravity Center -crop 200x200+0+0 +repage",
  :large => "-resize 500x500^ -gravity Center -crop 500x500+0+0 +repage" },
  default_url: "default_org.png"

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  filterrific(
  default_filter_params: { sorted_by: 'organization_name_desc' },
  available_filters: [
    :sorted_by,
    :search_query]
  )

  scope :search_query, lambda { |query|
    return nil if query.blank?
    terms = query.to_s.downcase.split(/\s+/)
    terms = terms.map { |e|
      ('%' + e.gsub('*', '%') + '%').sub(/%+/, '%')
    }
    num_of_conds = 1
    where(
      terms.map { |term|
        "(LOWER(organizations.name) LIKE ?)"
      }.join(' AND '),
      *terms.map { |e| [e] * num_of_conds }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^organization_name_/
      order("LOWER(organizations.name) #{ direction }")
    end

  }
  resourcify

end
