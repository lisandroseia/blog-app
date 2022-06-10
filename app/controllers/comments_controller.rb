class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @user = current_user

    respond_to do |format|
      data = params.require(:comment).permit(:text)
      @comment = Comment.new(author: @user, post: @post, text: data[:text])
      format.html do
        redirect_back(fallback_location: root_path)
      end
    end
  end
end
