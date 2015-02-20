  class RatingsController < ApplicationController
	def index
		#Jätetään pois koska oletusarvoinen index...
		@ratings = Rating.all
    @three_beers = Beer.top 3
    @three_breweries = Brewery.top 3
    @three_users = User.top 3
    @three_styles = Style.top 3
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

    if current_user.nil?
      redirect_to signin_path, notice:'you should be signed in'
    elsif @rating.save
      current_user.ratings << @rating  ## virheen aiheuttanut rivi
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end


  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back 
  end
end