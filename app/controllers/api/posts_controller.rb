class Api::PostsController <  ActionController::Base
  skip_before_action :authenticate_user!
  before_action :authorize_request

    def index
      @user = User.find(params[:user_id])
      render json: @user.posts
    end
  
    def show
      @post = Post.find_by(id: params[:id], author_id: params[:user_id])  
      render json: @post
    end
  end