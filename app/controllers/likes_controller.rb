class LikesController < ApplicationController
  before_action :set_post

  def create
    if @post.likes.exists?(user: current_user)
      @post.likes.find_by(user: current_user).destroy
      flash[:danger] = 'Disliked'
    else
      flash[:success] = 'Liked'
      @post.likes.create(user: current_user)
    end

    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
