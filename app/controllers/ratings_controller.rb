  class RatingsController < ApplicationController


	def index
    #@breweries = Brewery.top(3)
    #Rails.cache.write("beer top 3", Beer.top(3)) 
    @beers = Beer.top(3)
    #@styles = Style.top(3)
    @users = User.most_active(5)

    @ratings = Rating.recent
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