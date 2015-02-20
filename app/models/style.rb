class Style < ActiveRecord::Base
	has_many :beers

	def to_s
		"#{self.name}"
	end	

	def average
		return 0 if beers.empty?
		beers.map{|b| b.average}.sum/beers.count.to_f
  	end

  	def self.top(n)
	   sorted_by_rating_in_desc_order = self.all.sort_by{ |s| -(s.average) }.take(n)

	end

end
