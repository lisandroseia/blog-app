class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  after_save :increase_coments_counter
  after_destroy :decrease_coments_counter

  def increase_coments_counter
    post.increment!(:comments_counter)
  end

  def decrease_coments_counter
    post.decrement!(:comments_counter)
  end
end
