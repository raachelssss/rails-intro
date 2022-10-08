class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.get_ratings
    null = ""
    @movies = null
    link = false

    if not params[:ratings].nil?
      session[:ratings] = params[:ratings]
    else
      link = true
      @ratings_to_show = @all_ratings.to_h {|r| [r, '1']}
    end
    if not session[:ratings].nil?
      session[:ratings] = session[:ratings]
    else
      session[:ratings] = @all_ratings.to_h {|r| [r, '1']}
    end

    if not params[:filter].nil? 
      session[:filter] = params[:filter]
    else
      link = true
      @filter_by = null
    end
    
    if not session[:filter]
      session[:filter] = null
    else
      session[:filter] = session[:filter]
    end
    @ratings_to_show = session[:ratings]
    @filter_by = session[:filter]
    if link
      redirect_to movies_path({:filter=> @filter_by,
       :ratings=>@ratings_to_show})
    end
    @movies = Movie.with_ratings(@ratings_to_show).order(@filter_by)

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end