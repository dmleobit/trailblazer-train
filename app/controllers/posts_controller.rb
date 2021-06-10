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
    result = Post::Operation::CreateOrDestroyLike.(user: current_user, origin: post)

    flash[result[:flash_type]] = result[:message]

    redirect_to posts_path
  end

  def create_random
    result = Post::Operation::CreateRandom.(user: current_user)

    result.success? ? flash['notice'] = 'Success created' : flash['alert'] = 'Failure create'

    redirect_to posts_path
  end

  def destroy_all
    current_user.posts.includes(:likes, :comments).destroy_all

    flash['notice'] = 'All posts were destroyed'

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
