class User < ActiveRecord::Base
	has_many :ratings   # käyttäjällä on monta ratingia
	has_many :beers, through: :ratings
	has_many :memberships
	has_many :beer_clubs, through: :memberships


	include RatingAverage

	validates :username,  uniqueness: true
	validates :username, length: { minimum: 3,
	 								maximum: 15 }
	validates :password, length: { minimum: 3}
	validates :password, :format => {:with =>/[A-Z]/}


	has_secure_password

end
