require 'rails_helper'

RSpec.describe 'User', type: :model do
  context 'User Model' do
    subject { User.create(name: 'Lisandro') }
    before { subject.save }

    it 'User does not have errors if name is initialized' do
      expect(subject).to be_valid
    end

    it 'Name should not be nil' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'Posts_counter is 0 by default' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end

    it 'should return three most recent posts' do
      (1..5).each do
        Post.create(author: subject, title: 'Post', text: 'Lorem Ipsem')
      end
      recent_posts = subject.last_posts
      expect(recent_posts.length).to eq(3)
    end
  end
end
