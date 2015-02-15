class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :edit, :update, :destroy]
  
  def index
    #Jätetään pois koska oletusarvoinen index...
    @memberships = Membership.all
    render :index    # renderöin näkymätemplate /app/views/memberships/index.html
  end

  def new
    @beer_clubs = BeerClub.all.reject{ |b| b.members.include? current_user }
    @membership = Membership.new
  end

  def create
    #ensin requirella otetaan paramsin sisältä luotavan olion tiedot sisältävä hash
    #luetellaan permitillä ne kentät, joiden arvon massasijoitus sallitaan
    @membership = Membership.new (membership_params)
    @membership.user = current_user
    
    respond_to do |format|
      if @membership.save
        format.html { redirect_to @membership.beer_club, notice: "You just joined #{@membership.beer_club.name}" }
        format.json { render :show, status: :created, location: @membership }
      else
        @beerclubs = BeerClub.all.reject{ |b| b.members.include? current_user }
        format.html { render :new }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @membership.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Membership was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_membership
    @membership = Membership.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def membership_params
    params.require(:membership).permit(:user_id, :beer_club_id)
  end
end