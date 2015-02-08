class Brewery < ActiveRecord::Base
	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	validates :name, presence: true
  	validates :year, numericality: { greater_than_or_equal_to: 1024,
                                   less_than_or_equal_to: ->(_){Time.now.year} }

	include RatingAverage

	def to_s
		"#{self.name}"
	end	
end
