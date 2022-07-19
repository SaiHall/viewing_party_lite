class UsersController < ApplicationController
  def new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to "/dashboard"
    else
      redirect_to "/register"
      flash[:notice] = user.errors.full_messages.last
    end
  end

  def show
    @user = current_user
    @invited = ViewingParty.invited(@user)
  end

  def discover
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
