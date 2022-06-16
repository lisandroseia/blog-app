class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  after_save :increase_posts_counter
  after_destroy :decrease_posts_counter
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true }, comparison: { greater_than_or_equal_to: 0 }

  def last_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def increase_posts_counter
    author.increment!(:posts_counter)
  end

  def decrease_posts_counter
    author.decrement!(:posts_counter)
  end
end
