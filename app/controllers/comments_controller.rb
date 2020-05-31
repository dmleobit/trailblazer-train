class CommentsController < ApplicationController
  before_action :set_post

  def index
    @comments = @post.comments
    @comment = current_user.comments.new
  end

  def create
    @comment = current_user.comments.new(coment_params)
    if @comment.save
      flash[:success] = 'Comment was created'
    else
      flash[:error] = 'Sorry, some error'
    end

    redirect_to comments_path(@post)
  end

  private

  def coment_params
    params.require(:comment).permit(:text).merge(post: @post)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
