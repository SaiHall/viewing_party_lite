class ViewingPartiesController < ApplicationController

  def new
    @movie = MovieFacade.create_movie_details(params[:movie_id])
    @user = current_user
    @users = User.all
  end

  def create
    if !current_user
      @movie = MovieFacade.create_movie_details(params[:movie_id])
      redirect_to "/movies/#{@movie.id}"
      flash[:notice] = "Please log in or register to create a viewing party"
    end
  end
end
