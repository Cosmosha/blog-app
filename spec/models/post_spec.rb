require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:author) do
    User.create(
      name: 'Tom',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Teacher from Mexico.'
    )
  end

  subject do
    Post.new(
      author: author,
      title: 'Hello RoR',
      text: 'it working'
    )
  end

  describe 'validations' do
    it 'title should be present' do
      subject.title = ''
      expect(subject).to_not be_valid
    end

    it 'title should have less than 250 characters' do
      subject.title = 'Helloworld' * 50
      expect(subject).to_not be_valid
    end

    it 'comments_counter should be an integer' do
      subject.comments_counter = 'one'
      expect(subject).to_not be_valid
    end

    it 'comments counter should be greater than or equal to 0' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'likes counter should be an integer' do
      subject.likes_counter = 'one'
      expect(subject).to_not be_valid
    end

    it 'likes counter should be greater than or equal to 0' do
      subject.likes_counter = -2
      expect(subject).to_not be_valid
    end
  end

  describe '#update_post_counter' do
    it 'should update the post counter by 1' do
      expect { subject.save }.to change { author.reload.posts_counter }.by(1)
    end
  end

  describe '#recent_comments' do
    it 'should return five recent comments' do
      5.times do |i|
        Comment.create(
          author: author,
          post: subject,
          text: "comment#{i + 1}",
          created_at: (i + 1).days.ago
        )
      end

      expect(subject.recent_comments.length).to eql(5)
    end
  end 
end
