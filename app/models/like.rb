class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  after_save :increase_posts_counter
  after_destroy :decrease_posts_counter

  def increase_posts_counter
    post.increment!(:likes_counter)
  end

  def decrease_posts_counter
    post.decrement!(:likes_counter)
  end
end
