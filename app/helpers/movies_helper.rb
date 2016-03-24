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

end