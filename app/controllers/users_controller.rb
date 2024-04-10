class UsersController < ApplicationController
  def profile
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end
end
