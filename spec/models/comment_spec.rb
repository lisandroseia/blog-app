require 'rails_helper'

RSpec.describe 'Comment', type: :model do
  describe 'Comment Model' do
    before(:example) do
      @user = User.first
      @post = Post.create(author: @user, title: 'Post', text: 'Lorem Ipsem')
    end

    subject { Comment.new(text: 'Hi', author: @user, post: @post) }
    before { subject.save }

    it 'Comment is valid' do
      expect(subject).to be_valid
    end

    it 'Title is not null' do
      subject.text = nil
      expect(subject).to_not be_valid
    end

    it 'comments_counter increases' do
      value = @post.comments_counter
      Comment.create(text: 'Hi', author: @user, post: @post)
      expect(@post.comments_counter).to eq(value + 1)
    end
  end
end
