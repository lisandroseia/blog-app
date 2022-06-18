class Api::CommentsController <  ActionController::Base
  skip_before_action :authenticate_user!
  before_action :authorize_request


  def index
    @post = Post.find_by(id: params[:post_id], author_id: params[:user_id])
    render json: @post.comments
  end

  def create
    @post = Post.find_by(id: params[:post_id], author_id: params[:user_id])
    @comment = Comment.create(comment_params.merge(author_id: current_user.id, post_id: @post.id))
    render json: { message: 'Comment Created successfully' }
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
