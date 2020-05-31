module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
      user = UserFromOmniauth.call(request.env["omniauth.auth"])

      return redirect_to new_user_registration_url unless user

      sign_in_and_redirect user, event: :authentication
    end

    def failure
      flash[:error] = 'You was not signed in'
      redirect_to root_path
    end
  end
end
