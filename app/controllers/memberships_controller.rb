class MembershipsController < ApplicationController
  def index
    #Jätetään pois koska oletusarvoinen index...
    @memberships = Memberships.all
    render :index    # renderöin näkymätemplate /app/views/memberships/index.html
  end

  def new
    @membership = Membership.new
    @beerclubs = BeerClub.all
  end
  def create
    #ensin requirella otetaan paramsin sisältä luotavan olion tiedot sisältävä hash
    #luetellaan permitillä ne kentät, joiden arvon massasijoitus sallitaan
    @membership = Membership.new params.require(:membership).permit(:beer_club_id)
    
    if @membership.save
      current_user.memberships << @membership
      redirect_to user_path current_user
    else
      @beerclubs = BeerClub.all
      render :new
    end
  end


  def destroy
    rating = Rating.find(params[:id])
    rating.delete
    redirect_to :back
  end
end