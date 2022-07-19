class UsersController < ApplicationController
  def new
  end

  def create
    user = User.create(user_params)
    if user.save
      redirect_to "/users/#{user.id}"
    else
      redirect_to "/register"
      flash[:notice] = user.errors.full_messages.last
    end
  end

  def show
    @user = User.find(params[:id])
    @invited = ViewingParty.invited(@user)
  end

  def discover
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
