module EventsHelper

  def display_error_events(field)
    return if @event.nil?
    if @event.errors[field].any?
        field.to_s.capitalize.sub("_", " ") + " " + @event.errors[field].first
    end
  end

  def active_events(org_or_user)
    org_or_user.events.where("end_time >= ?", Time.now).order(:start_time).
               page(params[:page]).per(3)
  end

  def past_events(org_or_user)
    org_or_user.events.where("end_time < ?", Time.now).order(:start_time).
               page(params[:page]).per(3)
  end

end
