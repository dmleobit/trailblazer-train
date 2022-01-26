class CommentsController < ApplicationController
  before_action :set_post, only: %i[index create]
  before_action :set_comment, only: %i[like]

  def index
    result = Comment::Operation::Index.(post: @post)

    @comments = result[:comments]
    @comment = result[:model]
  end

  def create
    result = Comment::Operation::Create.(params: coment_params)

    if result.success?
      flash[:success] = 'Comment was created'
    else
      flash[:alert] = result['contract.default'].errors.full_messages[0]
    end

    redirect_to comments_path(@post)
  end

  def like
    result = Comment::Operation::Like.call(user: current_user, origin: @comment)
    flash[result[:flash_type]] = result[:message]

    redirect_to comments_path(@comment.post)
  end

  private

  def coment_params
    params.require(:comment).permit(:text).merge(post: @post, user: current_user)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
