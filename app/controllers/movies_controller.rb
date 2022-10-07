class MoviesController < ApplicationController

    def show
      id = params[:id] # retrieve movie ID from URI route
      @movie = Movie.find(id) # look up movie by unique ID
      # will render app/views/movies/show.<extension> by default
    end
  
    def index
      @all_ratings = Movie.get_ratings
      @ratings_to_show = []
      @selected = ""
      if(!params[:ratings].nil?)
        if (params[:ratings] != session[:ratings_to_show_hash])
          session[:ratings_to_show_hash] = params[:ratings]
          @ratings_to_show = params[:ratings]
        end
        if (params[:order] != session[:selected])
          session[:selected] = params[:order]
          @selected = params[:order]
        end

      elsif(!session[:ratings_to_show_hash].nil?)
        redirect_to movies_path(order: session[:selected], ratings: session[:ratings_to_show_hash])
      else
        if (!params[:ratings].nil?)
          @ratings_to_show = params[:ratings].keys
        end
        @selected = params[:order]
      end

      # Filtering by ratings
      if (!params[:ratings].nil?)
        @ratings_to_show = params[:ratings].keys
        @movies = Movie.with_ratings(params[:ratings].keys) #@movies = Movie.all
      else
        @ratings_to_show = @all_ratings
        @movies = Movie.with_ratings(nil)
      end
  
      # Ordering by title or release_date
      if(params[:order] == 'title')
        @selected = "title"
        @movies = @movies.order(:title)
      end
      if(params[:order] == 'release_date')
        @selected = "release_date"
        @movies = @movies.order(:release_date)
      end
  
      session[:ratings] = @ratings_to_show.to_h {|i| [i, '1']}
      session[:selected] = @selected

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