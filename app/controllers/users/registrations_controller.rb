module Users

  class RegistrationsController < Devise::RegistrationsController
    def update
      account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
      @user = User.find(current_user.id)

      if needs_password? && !(["facebook", "twitter"].include?(resource.provider))
        successfully_updated = @user.update_with_password(account_update_params)
      else
        account_update_params.delete('password')
        account_update_params.delete('password_confirmation')
        account_update_params.delete('current_password')
        successfully_updated = @user.update_attributes(account_update_params)
      end

      if successfully_updated
        set_flash_message :notice, :updated
        bypass_sign_in(@user)
        redirect_to user_path(current_user)
      else
        render 'edit'
      end
    end

    private

    def needs_password?
      @user.email != params[:user][:email] || params[:user][:password].present?
    end
  end
end
