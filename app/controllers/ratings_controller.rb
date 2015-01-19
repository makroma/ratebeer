class RatingsController < ApplicationController
	def index
		#Jätetään pois koska oletusarvoinen index...
		@ratings = Rating.all
		render :index    # renderöin näkymätemplate /app/views/ratings/index.html
	end

	def new
    @rating = Rating.new
    @beers = Beer.all
  end
  def create
  		#ensin requirella otetaan paramsin sisältä luotavan olion tiedot sisältävä hash
  		#luetellaan permitillä ne kentät, joiden arvon massasijoitus sallitaan
  	 Rating.create params.require(:rating).permit(:score, :beer_id)

  	 # reittauksen luomisen jälkeen käyttäjän selain uudelleenohjataan 
  	 #kaikki reittaukset sisältävälle sivulle
  	 redirect_to ratings_path
  end
  def destroy
    rating = Rating.find(params[:id])
    rating.delete
    redirect_to ratings_path
  end
end