class UsersController < ApplicationController
  def index
    @users = User.all
    @user_current = current_user
  end

  def show
    @user_current = User.find(params[:id])
  end
end
