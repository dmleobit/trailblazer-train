class UsersController < ApplicationController
  def index
    @users = User.all.includes(:avatar_attachment)
  end

  def show
    @posts = user.posts
  end

  def requested_to_me
    @records = current_user.received_requests.pending.includes(:initiator)
  end

  def my_requests
    @records = current_user.sent_requests.includes(:receiver).pending.includes(:initiator)
  end

  def my_friends
    @records = current_user.sent_requests
                           .or(current_user.received_requests)
                           .includes(:initiator, :receiver)
                           .accepted
  end

  private

  def user
    @user ||= User.includes(:comments, :likes).find(params[:id])
  end
end
