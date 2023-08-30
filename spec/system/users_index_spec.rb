require 'rails_helper'

RSpec.describe "User/Index" do
  before do
    driven_by(:rack_test)
    @users = [
      User.create(name: 'Test User', bio: 'it me again', photo: 'https://picsum.photos/200/300', posts_counter: 1),
      User.create(name: 'Test User 2', bio: 'Me is all me again', photo: 'https://picsum.photos/200/300', posts_counter: 1)
    ]
  end

  describe "index page" do
  
    it 'should display username' do
      visit '/users'
      @users.each do |user|
        expect(page).to have_content(user.name)
      end
    end

    it 'should display photo' do
      visit '/users'
      @users.each do |user|
        expect(page).to have_selector("img[src='#{user.photo}']")
      end
    end

    it 'should display number of posts' do
      visit '/users'
      @users.each do |user|
        expect(page).to have_content("Number of Posts: #{user.posts_counter}")
      end
    end

    it 'should redirect to the user show page' do
      user = User.create(name: 'Tommy', bio: 'it me again', photo: 'https://picsum.photos/200/300', posts_counter: 1)
      visit '/users'
      click_link user.name
      expect(current_path).to eq(user_path(user.id))
    end

  end
  
end
