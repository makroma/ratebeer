require 'rails_helper'

describe "Beers" do
	let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")

  end

  it "new beer is added" do
    visit new_beer_path
    fill_in('beer[name]', with:'iso 3')
    select('Weizen', from:'beer[style]')
    select('Koff', from:'beer[brewery_id]')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)

    expect(Beer.first.name).to eq("iso 3")

  end
end