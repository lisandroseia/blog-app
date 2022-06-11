require 'rails_helper'

RSpec.describe 'Like', type: :model do
  describe 'Like Model' do
    before(:example) do
      @user = User.first
      @post = Post.create(author: @user, title: 'Post', text: 'Lorem Ipsem')
    end

    subject { Like.new(author: @user, post: @post) }
    before { subject.save }

    it 'Like is valid' do
      expect(subject).to be_valid
    end

    it 'likes increases' do
      new_post = Post.create(author: @user, title: 'new post', text: 'Lorem Ipsem')
      value = new_post.likes_counter
      Like.create(author: @user, post: new_post)
      expect(@post.likes_counter).to eq(value + 1)
    end
  end
end
