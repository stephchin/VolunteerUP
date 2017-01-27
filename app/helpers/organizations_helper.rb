module OrganizationsHelper

  def display_error_org(field)
    if @organization.errors[field].any?
        field.to_s.capitalize + " " + @organization.errors[field].first
    end
  end

end
