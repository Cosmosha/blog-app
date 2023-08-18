require 'rails_helper'

RSpec.describe Comment, type: :model do
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

  subject do
    Comment.new(
      author: author,
      post: post,
      text: 'A good one'
    )
  end

  describe '#update_comment_counter' do
    it 'should increase comments counter after create' do
      expect { subject.save }
        .to change { post.reload.comments_counter }.by(1)
    end

    it 'should decrease comments counter after destroy' do
      comment = Comment.create(
        author: author,
        post: post,
        text: 'A good one'
      )

      expect { comment.destroy }
        .to change { post.reload.comments_counter }.by(-1)
    end
  end
end
