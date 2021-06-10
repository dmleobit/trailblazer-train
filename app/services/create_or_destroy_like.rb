class CreateOrDestroyLike < ApplicationService
  def initialize(current_user, origin)
    @current_user = current_user
    @origin = origin
  end

  def call
    return destroy_like if like

    create_like
  end

  private

  attr_accessor :current_user, :origin

  def like
    @like ||= origin.likes.find_by(user: current_user)
  end

  def destroy_like
    like.destroy
    OpenStruct.new(
      flash_type: 'alert',
      flash_message: 'Disliked'
    )
  end

  def create_like
    origin.likes.create(user: current_user)
    OpenStruct.new(
      flash_type: 'success',
      flash_message: 'Liked'
    )
  end
end
