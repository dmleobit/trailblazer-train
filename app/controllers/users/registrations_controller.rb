# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  after_action :send_welcome_email

  private

  def send_welcome_email
    UserMailer.welcome(@user).deliver_later if @user.persisted?
  end
end
