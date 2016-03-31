class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #initialize redirect
    redirect = false

    #remember from last session
    if(!params.has_key?(:order_by))
      if(session.has_key?(:order_by))
        params[:order_by] = session[:order_by]
        redirect = true
      end
    end
    if(!params.has_key?(:ratings))
      if(session.has_key?(:ratings))
        params[:ratings] = session[:ratings]
        redirect = true
      end
    end

    #redirect using remembered parameters
    if redirect == true
      #save flash messages?
      flash.keep
      #then redirect
      redirect_to movies_path(:order_by => params[:order_by], :ratings => params[:ratings])
    end
    #print all params for testing
    puts params

    #initialize instance variables
    @movies = Movie.all
    @selected_movies = @movies
    @ordered_by = params[:order_by] if params.has_key? 'order_by'
    @all_ratings = Movie.get_ratings

    #grab selected ratings and compile selected_movies list
    if(params.has_key?(:ratings))
      puts "Compiling selected movies!!!"
      @selected_ratings = params[:ratings].keys
      puts @selected_ratings
      #update selected_movies
      @selected_movies = []
      @movies.each do |movie|
        @selected_ratings.each do |rating|
          if(movie.rating == rating)
            @selected_movies.append(movie)
          end
        end
      end
      #update @movies
      @movies = @selected_movies
    end

    #save ratings
    session[:ratings] = params[:ratings]

    #update session with params
    if @ordered_by == 'title'
      session[:order_by] = params[:order_by]
      @movies = @movies.sort_by{|m| m.title.downcase}
    elsif @ordered_by == 'release_date'
      session[:order_by] = params[:order_by]
      @movies = @movies.sort_by{|m| m.release_date}
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
end
