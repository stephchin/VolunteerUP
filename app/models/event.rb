class Event < ApplicationRecord
  #if an event is destroyed, this destroys the link between event and user, but not the actual user
  has_many :user_events, :dependent => :destroy
  has_many :users, through: :user_events

  belongs_to :organization

  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :volunteers_needed, presence: true
  validates :organization, presence:true

  geocoded_by :address
  after_validation :geocode

  def address
    "#{street}, #{city} #{state} #{postal_code}"
  end

  def remaining_vol
    volunteers_needed - self.users.count
  end

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_query,
      :with_start_time,
      :with_end_time,
    ]
  )

  scope :search_query, lambda { |query|
    return nil if query.blank?
    # condition query, parse into individual keywords from a string
    terms = query.to_s.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      ('%' + e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    num_or_conds = 2
    where(
      terms.map { |term|
        "(LOWER(events.name) LIKE ? OR LOWER(events.cause) LIKE ?)"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      # Simple sort on the created_at column.
      # Make sure to include the table name to avoid ambiguous column names.
      # Joining on other tables is quite common in Filterrific, and almost
      # every ActiveRecord table has a 'created_at' column.
    when /^name_/
      # Simple sort on the name columns
      order("LOWER(events.name) #{ direction }")
    when /^start_time_/
      # Simple sort on the date column
      order("(events.start_time)")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  scope :with_start_time, lambda { |reference_time|
    where('events.start_time >= ?', reference_time)
  }

  # always exclude the upper boundary for semi open intervals
  scope :with_end_time, lambda { |reference_time|
    where('events.end_time <= ?', reference_time)
  }

  def self.options_for_sorted_by
    [
      ['Event Name (Accending)', 'name_asc'],
      ['Event Name (Decending)', 'name_desc'],
      ['Date', 'start_time_desc']
    ]
  end

  resourcify
end
