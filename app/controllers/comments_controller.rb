class CommentsController < ApplicationController
  before_action :set_post, only: %i[index create]
  before_action :set_comment, only: %i[like]

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

  def like
    if @comment.likes.exists?(user: current_user)
      @comment.likes.find_by(user: current_user).destroy
      flash[:danger] = 'Disliked'
    else
      flash[:success] = 'Liked'
      @comment.likes.create(user: current_user)
    end

    redirect_to comments_path(@comment.post)
  end

  private

  def coment_params
    params.require(:comment).permit(:text).merge(post: @post)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
