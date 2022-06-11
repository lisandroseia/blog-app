require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'Post Model' do
    before(:example) do
      @user = User.first
    end

    subject do
      Post.create(author: @user, title: 'Post', text: 'Lorem Ipsem')
    end
    before { subject.save }

    it 'title cant have more than 250 chars' do
      str = '0123456789'
      (1..26).each do
        str += str
      end
      subject.title = str
      expect(subject).to_not be_valid
    end

    it 'comments_counter and likes_counter are set by default' do
      expect(subject).to be_valid
    end

    it 'comments_counter is >= 0' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'likes_counter is >= 0' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end

    it 'Title can not be nil' do
      subject.title = nil
      expect(subject).to_not be_valid
    end
    it 'Last_comments return 5 last comments' do
      (1..6).each do
        Comment.create(text: 'post', author: @user, post: subject)
      end
      lasts = subject.last_comments
      expect(lasts.length).to eq(5)
    end
  end
end
