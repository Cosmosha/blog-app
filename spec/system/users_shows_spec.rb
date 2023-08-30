require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'Show page' do
    let(:user) { User.create(name: 'Test User', bio: 'its me again jah jah', photo: 'https://picsum.photos/200/300', posts_counter: 1) }
    let!(:post) { user.posts.create(title: 'Test Post', text: 'This is the body of the post.', author_id: user.id) }
    
    it "I can see the user's profile picture." do
      visit user_path(user)
      expect(page).to have_selector("img[src='#{user.photo}']")
    end

  #   it "I can see the user's username." do
  #     user = User.first
  #     visit user_path(user)

  #     expect(page).to have_content(user.name)
  #   end

  #   it 'I can see the number of posts the user has written.' do
  #     user = User.first
  #     visit user_path(user)

  #     expect(page).to have_content(user.posts_counter)
  #   end

  #   it "I can see the user's bio." do
  #     user = User.first
  #     visit user_path(user)

  #     expect(page).to have_content(user.bio)
  #   end

  #   it "I can see the user's first 3 posts." do
  #     user = User.first
  #     visit user_path(user)

  #     expect(page).to have_content('Post #1')
  #     expect(page).to have_content('Post #2')
  #     expect(page).to have_content('Post #3')
  #   end

  #   it "I can see a button that lets me view all of a user's posts." do
  #     user = User.first
  #     visit user_path(user)

  #     assert_text 'See all posts'
  #   end

  #   it "When I click a user's post, it redirects me to that post's show page." do
  #     user = User.first
  #     visit user_path(user)
  #     click_on 'Post #1'

  #     expect(page).to have_current_path(user_post_path(user, user.posts.first))
  #   end

  #   it "When I click to see all posts, it redirects me to the user's post's index page." do
  #     user = User.first
  #     visit user_path(user)
  #     click_on 'See all posts'

  #     expect(page).to have_current_path(user_posts_path(user))
  #   end
  end
end
