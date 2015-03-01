class Beer < ActiveRecord::Base
	include RatingAverage

	belongs_to :brewery, touch: true
	belongs_to :style, touch: true
	has_many :ratings, dependent: :destroy
	has_many :raters, -> { uniq }, through: :ratings, source: :user


	validates :name, presence: true

	def to_s
		"#{self.name}, #{self.brewery.name}"
	end	

	def average
		return 0 if ratings.empty?
    	ratings.map{ |r| r.score }.sum / ratings.count.to_f
  	end

  	def self.top(n)
	   sorted_by_rating_in_desc_order = self.all.sort_by{ |b| -(b.average_rating||0) }.take(n)
	end
end
