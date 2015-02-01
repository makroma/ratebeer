class User < ActiveRecord::Base
	 has_many :ratings   # käyttäjällä on monta ratingia

	 include RatingAverage

	 validates :username, uniqueness: true
	 validates :username, length: { minimum: 3 }
end
