class Post < ApplicationRecord
  has_many :likes
  has_many :comments, foreign_key: :post_id
  belongs_to :author, class_name: 'User'
  validates :title, presence: true, length: { maximum: 550 }
  validates :comments_counter, numericality: { only_integer: true }
  validates :likes_counter, numericality: { only_integer: true }

  after_create :increment_user_posts_counter
  before_destroy :decrement_user_posts_counter

  def increment_user_posts_counter
    author.increment!(:posts_counter)
  end

  def decrement_user_posts_counter
    author.decrement!(:posts_counter)
  end

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
end


