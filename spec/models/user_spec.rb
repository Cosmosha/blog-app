require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(
      name: 'Tom',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Teacher from Mexico.'
    )
  end

  before { subject.save }

  describe '#validation' do
    it 'name should be present' do
      subject.name = 'Tom'
      expect(subject).to be_valid
    end

    it 'posts counter should be an integer' do
      subject.posts_counter = 'none'
      expect(subject).to_not be_valid
    end

    it 'posts counter should be greater than 0' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end
  end

  describe '#recent_posts' do
    it 'should return 3 recent posts' do
      Post.create(author: subject, title: 'Hello RoR', text: 'Try Test', created_at: 5.days.ago)
      Post.create(author: subject, title: 'Hello RoR', text: 'Try Test', created_at: 4.days.ago)
      post1 = Post.create(author: subject, title: 'Hello RoR', text: 'Try Test', created_at: 3.days.ago)
      post2 = Post.create(author: subject, title: 'Hello RoR', text: 'Try Test', created_at: 2.days.ago)
      post3 = Post.create(author: subject, title: 'Hello RoR', text: 'Try Test', created_at: 1.days.ago)

      expect(subject.recent_posts.to_a).to eql([post3, post2, post1])
    end
  end
end
