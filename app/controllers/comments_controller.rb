class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @user = current_user

    respond_to do |format|
      data = params.require(:comment).permit(:text)
      @comment = Comment.new(author: @user, post: @post, text: data[:text])
      format.html do
        redirect_to user_post_url(id: params[:post_id]) if @comment.save
      end
    end
  end
end
