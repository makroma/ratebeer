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
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    
    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end


  def destroy
    rating = Rating.find(params[:id])
    rating.delete
    redirect_to :back
  end
end