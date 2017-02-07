module UsersHelper

  def display_error_user(field)
    if !@user.nil?
      if @user.errors[field].any?
          field.to_s.capitalize.sub("_", " ") + " " + @user.errors[field].first
      end
    end
  end

end
