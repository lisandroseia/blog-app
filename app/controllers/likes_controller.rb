class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    like = Like.new(author: @user, post: @post)
    respond_to do |format|
      format.html do
        if !Like.find_by(author_id: params[:user_id],
                         post_id: params[:post_id]) && like.save
          redirect_back(fallback_location: root_path)
        end
      end
    end
  end
end
