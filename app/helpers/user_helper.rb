module UserHelper
  def friend(record)
    record.initiator == current_user ? record.receiver : record.initiator
  end

  def avatar(user)
    user.avatar.attached? ? user.avatar : default_image
  end

  def request_button(user)
    if current_user.friend?(user)
      link_to "Friend", '#', class: 'btn btn-success'
    elsif current_user.pending_friend_request?(user)
      link_to "Pending friend request", '#', class: 'btn btn-info'
    else
      link_to  "Request to friend", friendships_path(user_id: user.id), method: :post, class: 'btn btn-warning'
    end
  end

  private

  def default_image
    'https://us.123rf.com/450wm/mialima/mialima1603/mialima160300025/55096766-male-user-icon-isolated-on-a-white-background-account-avatar-for-web-user-profile-picture-unknown-ma.jpg?ver=6'
  end
end
