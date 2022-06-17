require 'rails_helper'

RSpec.describe 'Post Show Page', type: :feature do
  before(:each) do
    visit new_user_session_path
    fill_in 'Email', with: 'lily@gmail.com'
    fill_in 'Password', with: 'lily12345'
    click_button('Log in')
    @user = User.find(3)
    @post = @user.posts.take
    visit user_post_path(@user.id, @post.id)
  end

  it 'has username' do
    expect(page).to have_content("by #{@user.name}")
  end

  it 'displays title' do
    expect(page).to have_content(@post.title)
  end

  it 'displays text' do
    expect(page).to have_content(@post.text)
  end

  it 'displays comments counter' do
    expect(page).to have_content("Comments: #{@post.comments_counter}")
  end

  it 'displays likes counter' do
    expect(page).to have_content("likes: #{@post.likes_counter}")
  end

  it 'displays the username and comment' do
    @post.comments.includes(:author).each do |comment|
      expect(page).to have_content("#{comment.author.name}: #{comment.text}")
    end
  end
end
