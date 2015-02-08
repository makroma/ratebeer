require 'rails_helper'
require 'spec_helper'

RSpec.describe Beer, type: :model do
  	describe "with a proper name and style" do
  		let(:beer){ Beer.create name:"Olvi", style:"Lager" }

		it "is saved to db" do
		    expect(beer).to be_valid
		    expect(Beer.count).to eq(1)
		end
	end
	 describe "with a improper name" do
  		let(:beer){ Beer.create name:"", style:"Lager" }

		it "is not saved to db" do
		    expect(beer).not_to be_valid
		    expect(Beer.count).to eq(0)
		end
	end
	describe "with a improper style" do
  		let(:beer){ Beer.create name:"Olvi", style:"" }

		it "is not saved to db" do
		    expect(beer).not_to be_valid
		    expect(Beer.count).to eq(0)
		end
	end
end
