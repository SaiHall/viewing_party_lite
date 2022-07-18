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

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      flash[:success] = "Welcome, #{user.email}!"
      redirect_to "/users/#{user.id}"
    else
      flash[:error] = "Invalid Credentials: Please try again"
      render :login_form
    end
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
