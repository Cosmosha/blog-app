require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe PostsController do
    let(:user) do
      User.create(
        name: 'Vilis',
        photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
        bio: 'Teacher from Latvia.',
        posts_counter: 7
      )
    end

    let(:post) do
      Post.create(
        author_id: user.id,
        title: 'Hello Post',
        text: 'Hi',
        comments_counter: 0,
        likes_counter: 0
      )
    end

    describe 'GET #index' do
      before do
        get user_posts_path(user)
      end

      it 'renders a successful response' do
        expect(response).to be_successful
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end

      it 'response body includes the right placeholders' do
        expect(response.body).to include('Showing All Posts')
      end
    end

    describe 'GET #show' do
      before do
        get user_post_path(user, post)
      end

      it 'returns a successful response' do
        subject
        expect(response).to be_successful
      end

      it 'renders the show template' do
        subject
        expect(response).to render_template(:show)
      end

      it 'response body includes correct placeholder text' do
        expect(response.body).to include('Show Posts by user<')
      end
    end
  end
end
