class Brewery < ActiveRecord::Base
	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	include RatingAverage

	def to_s
		"#{self.name}"
	end	
end
