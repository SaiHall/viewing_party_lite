class SessionController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.email}!"
      redirect_to "/users/#{user.id}"
    else
      flash[:error] = "Invalid Credentials: Please try again"
      render :new
    end
  end
end
