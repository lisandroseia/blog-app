class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    @like = Like.new
  end

  def show
    @user = current_user
    @post_current = Post.find(params[:id])
  end

  def new
    @post_current = Post.new
    respond_to do |format|
      format.html { render :new }
    end
  end

  def create
    respond_to do |format|
      format.html do
        @user = User.find(params[:user_id])
        data = params.require(:post).permit(:title, :text)
        post = Post.new(author: @user, title: data[:title], text: data[:text])
        if post.save
          redirect_to action: :index, user_id: @user.id
        else
          render :new
        end
      end
    end
  end

end
