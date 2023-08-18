require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:author) do
    User.create(
      name: 'Tom',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Teacher from Mexico.'
    )
  end

  let(:post) do
    Post.create(
      author: author,
      title: 'Hello RoR',
      text: 'it working'
    )
  end

  subject { Like.new(author: author, post: post) }

  describe '#update_likes_counter' do
    it 'increases the likes counter by 1' do
      expect { subject.save }.to change { post.reload.likes_counter }.by(1)
    end

    it 'decreases the likes counter by 1 when destroying' do
      like = subject
      like.save
      expect { like.destroy }.to change { post.reload.likes_counter }.by(-1)
    end
  end
end
