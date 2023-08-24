require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) do
    User.create(
      name: 'John Doe',
      photo: 'https://unsplash.com/photos/abcdef',
      bio: 'this is me doing hellorails',
      posts_counter: 5
    )
  end

  describe 'GET #index' do
    before(:each) do
      get users_path
    end

    it 'return http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renderes a correct template' do
      get '/users'
      expect(response).to render_template(:index)
    end

    it ' the body returns the correct placeholder' do
      expect(response.body).to include('List of Users')
    end
  end

  describe 'GET #show' do
    before(:each) do
      get users_path
    end

    it 'return http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders a correct template' do
      get user_show_path(1)
      expect(response).to render_template(:show)
    end

    it 'the body returns a correct placeholder' do
      get '/users/:id'
      expect(response.body).to include('User Details')
    end
  end
end
