class PostsController < ApplicationController
  def index
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

  def destroy

  end

  private

  def post_params
    params.require(:post).permit(:text)
  end
end
