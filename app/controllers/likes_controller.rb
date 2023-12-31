class LikesController < ApplicationController
  def create
    @like = Like.new(post_id: params[:post_id], author_id: params[:user_id])

    flash.now[:error] = 'Failed to like the post' unless @like.save
    redirect_to user_post_path(params[:user_id], params[:post_id])
  end
end
