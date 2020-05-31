class UserFromOmniauth < ApplicationService
  def initialize(omniauth_response)
    @response = omniauth_response
  end

  def call
    fetch_user_from_email || user_by_uid || create_user
  end

  private

  attr_reader :response

  def fetch_user_from_email
    User.find_by(email: omniauth_email)
  end

  def user_by_uid
    User.find_by(auth_params)
  end

  def create_user
    User.create!(user_params)
  end

  def user_params
    {
      email: omniauth_email || custom_email,
      password: Devise.friendly_token[0, 20],
      **auth_params
    }
  end
  
  def auth_params
    {
      provider: response.provider,
      uid: response.uid
    }
  end

  def omniauth_email
    response.info.email
  end

  def custom_email
    "#{response.uid}@#{response.provider}.com"
  end
end
