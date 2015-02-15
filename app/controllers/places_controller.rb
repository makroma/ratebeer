class PlacesController < ApplicationController
	before_action :set_places, only: [:search]


	def show
		#@place = places(params[:id])
    @city = session[:city]

    @place = BeermappingApi.places_in(@city).find {|p| p.id==params[:id]}

	end


  def index

  end

  def search

    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      session[:city] = @city
      render :index
    end
  end



  private
  def set_places
    @city = params[:city]
 		@places = BeermappingApi.places_in(@city)
  end
end	