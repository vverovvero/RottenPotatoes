class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all

    @ordered_by = params[:order_by] if params.has_key? 'order_by'
    @hilite_header = params[:header] if params.has_key? 'header'

    #hilite the header


    #update session with params
    if @ordered_by == 'title'
      #session[:order_by] = params[:order_by]
      @movies = @movies.sort_by{|m| m.title.downcase}
      @title_header = 'hilite'

    elsif @ordered_by == 'release_date'
      #session[:order_by] = params[:order_by]
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
