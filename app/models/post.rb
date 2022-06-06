class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :likes
  has_many :comments
  after_save :increase_posts_counter
  after_destroy :decrease_posts_counter

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
