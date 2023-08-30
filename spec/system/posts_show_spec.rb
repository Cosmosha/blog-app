require 'rails_helper'

RSpec.describe 'Posts/Show', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'show page' do
    let(:user) { User.create(name: 'Test User', bio: 'its me again jah jah', photo: 'https://picsum.photos/200/300', posts_counter: 1) }
    let!(:post) { user.posts.create(title: 'Test Post', text: 'This is the body of the post.', author_id: user.id) }
    let!(:comment) { post.comments.create(text: 'Test Comment', post_id: post.id, author_id: user.id) }

    before do
      visit user_post_path(user.id, post.id)
    end

    it 'displays the post\'s title' do
      expect(page).to have_content(post.title)
    end

    it 'displays who wrote the post' do
      expect(page).to have_content("by #{post.author.name}")
    end

    it 'displays the comments count' do
      expect(page).to have_content("Comments #{post.comments.count}")
    end

    it 'displays the likes count' do
      expect(page).to have_content("Likes #{post.likes_counter}")
    end

    it 'displays the post body' do
      expect(page).to have_content(post.text)
    end

    it 'displays the username of each commentor' do
      post.comments.each do |comment|
        expect(page).to have_content(comment.author.name)
      end
    end

    it 'displays the comment each commentor left' do
      post.comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
  end
end
