module EventsHelper

  def display_error(field)
    if @user.errors[field].any?
        field.to_s.capitalize + " " + @user.errors[field].first
    end
  end

  def display_error(field)
    if @organization.errors[field].any?
        field.to_s.capitalize + " " + @organization.errors[field].first
    end
  end

  def display_error(field)
    if @event.errors[field].any?
        field.to_s.capitalize.sub("_", " ") + " " + @event.errors[field].first
    end
  end

end
