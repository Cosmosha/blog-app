require 'rails_helper'

RSpec.describe "User/Index" do
  before do
    driven_by(:rack_test)
  end

  describe "index page" do
  
    user = User.create(name: 'Test User', bio: 'it me again', photo: 'https://picsum.photos/200/300', posts_counter: 1)

    it 'should display username' do
      visit '/users'
      expect(page).to have_content(user.name)
    end

    it 'should display photo' do
      visit '/users'
      expect(page).to have_selector("img[src*='#{user.photo}']")
    end

    it 'should display number of posts' do
      visit '/users'
      expect(page).to have_content("Number of Posts: #{user.posts_counter}")
    end

    it 'should redirect to the user show page' do
      user = User.create(name: 'Tommy', bio: 'it me again', photo: 'https://picsum.photos/200/300', posts_counter: 1)
      visit '/users'
      click_link user.name
      expect(current_path).to eq(user_path(user.id))
    end

  end
  
end
