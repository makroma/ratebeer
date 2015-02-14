require 'rails_helper'
require 'spec_helper'

describe "Beers" do
	let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")

  end

end