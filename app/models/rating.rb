class Rating < ActiveRecord::Base
	belongs_to :beer
	belongs_to :user   # rating kuuluu myös käyttäjään

	validates :score, numericality: { greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 50,
                                    only_integer: true }
                                    
	def to_s
		"#{self.beer.name} #{self.score}"
	end		
end
