class Api::AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login
  def authenticate
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response({ token: auth_token })
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
