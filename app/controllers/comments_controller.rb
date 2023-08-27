class CommentsController < ApplicationController
  before_action :find_user_and_post

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user

    if @comment.save
      flash[:success] = 'Comment was successfully added!'
    else
      flash.now[:error] = 'Failed to add comment'
    end

    respond_to do |format|
      format.html { redirect_to user_post_path(@user, @post) }
    end
  end

  private

  def find_user_and_post
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text, :post_id)
  end
end
