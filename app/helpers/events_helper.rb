module EventsHelper

  def display_error_events(field)

    if !@event.nil?
      if @event.errors[field].any?
          field.to_s.capitalize.sub("_", " ") + " " + @event.errors[field].first
      end
    end
  end

end
