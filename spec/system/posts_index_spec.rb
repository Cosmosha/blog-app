require 'rails_helper'

RSpec.describe 'Post/Index', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'Index page' do
    let(:user) { User.create(name: 'Test User', bio: 'its me again jah jah', photo: 'https://picsum.photos/200/300', posts_counter: 2) }
    let!(:post) { user.posts.create(title: 'Test Post', text: 'This is the body of the post.') }

    before do
      visit user_posts_path(user.id)
    end

    it 'displays the user profile picture' do
      expect(page).to have_selector("img[src*='#{user.photo}']")
    end

    it 'displays the user username' do
      expect(page).to have_content(user.name)
    end

    it 'displays the number of posts the user has written' do
      expect(page).to have_content("Number of Posts: 3")
    end

    it 'displays a post\'s title' do
      expect(page).to have_content(post.title)
    end

    it 'displays some of the post\'s body' do
      expect(page).to have_content(post.text[0..3]) # Adjust the range as needed
    end

    it 'displays the first comments on a post' do
      post.recent_comments.each do |comment|
        expect(page).to have_content("#{comment.author.name}: #{comment.text}")
      end
    end

    it 'displays how many comments a post has' do
      expect(page).to have_content("Comments #{post.comments_counter}")
    end

    it 'displays how many likes a post has' do
      expect(page).to have_content("Likes #{post.likes_counter}")
    end

    it 'displays a section for pagination if there are more posts' do
      expect(page).to have_content('Previous')
      expect(page).to have_content('Next')
    end

    it 'redirects to the post show page when clicking on a post' do
      click_link post.title
      expect(current_path).to eq(user_post_path(user.id, post.id))
      expect(page).to have_content(post.title)
    end
  end
end
