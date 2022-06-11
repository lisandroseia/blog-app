class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @user = current_user

    respond_to do |format|
      data = params.require(:comment).permit(:text)
      @comment = Comment.new(author: @user, post: @post, text: data[:text])
      format.html do
        if @comment.save
          flash[:success] = 'Comment added succesfully'
        else
          flash[:error] = 'Something went wrong. comment not added :('
        end
        redirect_back(fallback_location: root_path)
      end
    end
  end
end
