class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: @user.id)
  end

  def show
    @user = User.find(params[:user_id])

    @post = Post.where(author_id: @user.id).find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = 'Post has been created!'
      redirect_to user_post_path(current_user, @post)
    else
      flash.now[:alert] = 'Post has not been created.'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text) # Make sure these attributes match your model
  end
end
