class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  after_save :increase_likes_counter
  after_destroy :decrease_likes_counter

  def increase_likes_counter
    post.increment!(:likes_counter)
  end

  def decrease_likes_counter
    post.decrement!(:likes_counter)
  end
end
