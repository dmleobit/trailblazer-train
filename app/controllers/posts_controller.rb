class PostsController < ApplicationController
  def index
    # TODO: sort
    @posts = Post.all.includes(:user)
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
    result = CreateOrDestroyLike.call(current_user, post)
    flash[result.flash_type] = result.flash_message

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
