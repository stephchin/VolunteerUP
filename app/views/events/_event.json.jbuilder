json.extract! event, :id, :name, :description, :cause, :start_time, :end_time, :street, :city, :state, :postal_code, :country, :volunteers_needed, :created_at, :updated_at
json.url event_url(event, format: :json)
