class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  after_create :increment_likes_counter
  before_destroy :decrement_likes_counter

  def increment_likes_counter
    post.increment!(:likes_counter)
  end

  def decrement_likes_counter
    post.decrement!(:likes_counter)
  end
end
