module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  #creates a string parameter (ie. title, )
  def create_order_params(column)
  	{order_by: column}
  end

  #add class = 'hilite' if header matches order_by parameter
  def find_hilite(header)
    params[:order_by].to_s == header ? 'hilite' : nil
  end

  # def pass_prev_params()
  #   # return {order_by: 'title'}
  # end

  def find_check(this_rating)
    # puts "find_check called"
    # puts this_rating
    # params ratings is empty on the user's first visit
    if(!params.has_key?(:ratings))
      return true
    else
      params[:ratings].keys.each do |rating|
        if this_rating == rating
          return true
        end
      end
      return false
    end
  end


  # #get checked_movies
  # def get_checked_movies(movies, checked_ratings)
  # 	checked_movies = []
  # 	movies.each do |movie|
  # 		if checked_ratings.member?(movie.rating)
  # 			checked_movies.push(movie)
  # 		end
  # 	end
  # 	return checked_movies
  # end

end