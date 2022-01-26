class User::Cell < Cell::Concept
  def show
    render
  end

  private

  def avatar
    model.avatar.attached? ? url_for(model.avatar) : default_image
  end

  def request_button
    if decorated_user.friend?(model)
      link_to "Friend", '#', class: 'btn btn-outline-success'
    elsif decorated_user.pending_friend_request?(model)
      link_to "Pending friend request", '#', class: 'btn btn-outline-info'
    else
      link_to  "Request to friend", friendships_path(user_id: model.id), method: :post, class: 'btn btn-outline-warning'
    end
  end

  def decorated_user
    decorated_user ||= options[:current_user].decorate
  end

  def default_image
    'https://us.123rf.com/450wm/mialima/mialima1603/mialima160300025/55096766-male-user-icon-isolated-on-a-white-background-account-avatar-for-web-user-profile-picture-unknown-ma.jpg?ver=6'
  end
end
