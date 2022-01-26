module UserHelper
  def friend(record)
    record.initiator == current_user ? record.receiver : record.initiator
  end

  def avatar(user)
    user.avatar.attached? ? user.avatar : default_image
  end

  private

  def default_image
    'https://us.123rf.com/450wm/mialima/mialima1603/mialima160300025/55096766-male-user-icon-isolated-on-a-white-background-account-avatar-for-web-user-profile-picture-unknown-ma.jpg?ver=6'
  end
end
