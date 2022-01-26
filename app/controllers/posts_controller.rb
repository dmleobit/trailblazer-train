class PostsController < ApplicationController
  def index
    # TODO: sort
    @posts = Post.all.includes(:user)
  end

  def new
    @post = Post.new
  end

  def create
    result = Post::Operation::Create.(params: post_params, current_user: current_user)

    if result.success?
      redirect_to posts_path, notice: 'Post has been created!'
    else
      @post = result['contract.default'].model
      @errors = result['contract.default'].errors
      return render :new
    end
  end

  def like
    result = Post::Operation::Like.(user: current_user, origin: post)

    flash[result[:flash_type]] = result[:message]

    redirect_to posts_path
  end

  def create_random
    result = Post::Operation::CreateRandom.(user: current_user)

    result.success? ? flash['notice'] = 'Success created' : flash['alert'] = 'Failure create'

    redirect_to posts_path
  end

  def destroy_all
    current_user.posts.includes(:likes, comments: [:likes]).destroy_all

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
