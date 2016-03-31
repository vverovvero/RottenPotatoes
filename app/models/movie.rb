class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date
  # has_many :ratings 

  def self.get_ratings
  	return ['G', 'PG', 'PG-13', 'R', 'NC-17']
  	# ratings = []
  	# self.select(:rating).uniq.each do |movie|
  	# 	ratings.push(movie.rating)
  	# end
  	# return ratings
  end

end
