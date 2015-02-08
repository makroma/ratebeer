require 'rails_helper'

include OwnTestHelper

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user2) { FactoryGirl.create :user }
  let!(:user1) { FactoryGirl.create :user, username:"jorma" }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user2.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "has count of ratings" do

    r =  Rating.create score:10, beer_id:1
    user2.ratings << r
    visit ratings_path

    expect(page).to have_content "number of ratings: #{user2.ratings.count}"


    #expect(current_path).to have_content "number of ratings: 1"
  end
  it "has ratings in user profile" do
      
      r =  Rating.create score:10, beer_id:1
      user2.ratings << r
      visit user_path(user2)
      expect(page).to have_content "iso 3 10"

  end
  it "has no other ratings in user profile" do
      
      r =  Rating.create score:10, beer_id:1
      user1.ratings << r
      visit user_path(user2)
      expect(page).not_to have_content "iso 3 10"

  end
  it "deleted rating is not in db" do
      
      r =  Rating.create score:10, beer_id:1, user:user2
     
      user2.ratings << r
      visit user_path(user2)
      expect(page).to have_content "iso 3 10"
      expect(user2.ratings).to include r

      expect{
        click_link "delete"
      }.to change{user2.ratings.count}.from(1).to(0)
      #save_and_open_page
     #expect(user2.ratings).to be_empty
  end
end