class Api::UsersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authorize_request, except: :create

  def index
    @users = User.all.order(created_at: :asc)
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end
end
