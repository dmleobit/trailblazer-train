class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @comments = user.comments
  end

  def update
    current_user.avatar.purge if current_user.avatar.attached?

    current_user.avatar.attach(user_params[:avatar])
  end

  def requested_to_me
    @records = current_user.received_requests.pending.includes(:initiator)
  end

  def my_requests
    @records = current_user.sent_requests.pending.includes(:initiator)
  end

  def my_friends
    @records = current_user.sent_requests.or(User.first.received_requests).accepted
  end

  private

  def user
    @user ||= User.includes(:comments, :likes).find(params[:id])
  end

  def user_params
    params.require(:user).permit(:avatar)
  end
end
