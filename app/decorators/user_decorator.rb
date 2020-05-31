class UserDecorator < ApplicationDecorator
  def friend?(user)
    UserFriendship.where(initiator: self, receiver: user).or(
      UserFriendship.where(receiver: self, initiator: user)
    ).accepted.exists?
  end

  def pending_friend_request?(user)
    UserFriendship.where(initiator: self, receiver: user).or(
      UserFriendship.where(receiver: self, initiator: user)
    ).pending.exists?
  end
end
