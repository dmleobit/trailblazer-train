class FriendshipsController < ApplicationController
  before_action :set_received_request, only: %i[accept reject]
  before_action :set_sent_request, only: %i[cancel]

  def create
    friend_request = current_user.sent_requests.new(receiver_id: user_id)

    friend_request.save ? flash[:success] = 'User was created' : flash[:error] = 'Sorry, try again please'

    redirect_to users_path
  end

  def accept
    @friend_request.accepted!

    redirect_to requested_to_me_users_path
  end

  def reject
    @friend_request.destroy

    redirect_to requested_to_me_users_path
  end

  def cancel
    @friend_request.destroy

    redirect_to my_requests_users_path
  end

  private

  def set_received_request
    @friend_request = current_user.received_requests.find(params[:id])
  end

  def set_sent_request
    @friend_request = current_user.sent_requests.find(params[:id])
  end

  def user_id
    params.permit(:user_id)[:user_id]
  end
end
