class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
    @like = Like.new
  end

  def show
    @user = User.find(params[:user_id])
    @post_current = Post.find(params[:id])
  end

  def new
    @post_current = Post.new
    respond_to do |format|
      format.html { render :new }
    end
  end

  def create
    @user = current_user
    data = params.require(:post).permit(:title, :text)
    post = Post.new(author: @user, title: data[:title], text: data[:text])
    post.likes_counter = 0
    post.comments_counter = 0
    respond_to do |format|
      format.html do
        if post.save
          flash[:success] = 'Post created!'
          redirect_back(fallback_location: root_path)
        else
          flash[:error] = 'Try again'
          render :new
        end
      end
    end
  end

  def destroy
    id = params[:id]
    user_id = params[:user_id]
    Post.destroy(id)
    redirect_to action: :index, user_id:
  end
end
