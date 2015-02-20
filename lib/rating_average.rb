
module RatingAverage
  def average_rating
  	return 0 if ratings.empty?
    self.ratings.average(:score).to_f	
  end
end