class Brewery < ActiveRecord::Base
	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	validates :year, numericality: { greater_than_or_equal_to: 1042,
                                less_than_or_equal_to: Time.now.year,
                                only_integer: true }

	include RatingAverage

	def to_s
		"#{self.name}"
	end	
end
