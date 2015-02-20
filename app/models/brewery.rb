class Brewery < ActiveRecord::Base
	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	validates :name, presence: true
  	validates :year, numericality: { greater_than_or_equal_to: 1024,
                                   less_than_or_equal_to: ->(_){Time.now.year} }

    scope :active, -> { where active:true }
  	scope :retired, -> { where active:[nil,false] }

	include RatingAverage

	def to_s
		"#{self.name}"
	end
	def average
		return 0 if ratings.empty?
		self.beers.map{|b| b.average_rating}.sum / beers.count
    	#ratings.map{ |r| r.score }.sum / ratings.count.to_f
  	end

  	def self.top(n)
	   sorted_by_rating_in_desc_order = self.all.sort_by{ |b| -(b.average||0) }.take(n)
	end	
end
