module UsersHelper
  def display_error_user(field)
    return if @user.nil?
    if @user.errors[field].any?
      field.to_s.capitalize.sub('_', ' ') + ' ' + @user.errors[field].first
    end
  end

  def user_is_organizer?(org)
    current_user.organizations.all.include?(org)
  end

  def assign_organizer_role(user)
    user.add_role :organizer
    user.save
  end

end
