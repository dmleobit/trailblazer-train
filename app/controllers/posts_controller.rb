class PostsController < ApplicationController
  def index
    # TODO: sort
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    return render 'new' unless @post.save

    redirect_to posts_path
  end

  def like
    if post.likes.exists?(user: current_user)
      post.likes.find_by(user: current_user).destroy
      flash[:danger] = 'Disliked'
    else
      flash[:success] = 'Liked'
      post.likes.create(user: current_user)
    end

    redirect_to posts_path
  end

  private

  def post
    @post ||= Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:text)
  end
end
