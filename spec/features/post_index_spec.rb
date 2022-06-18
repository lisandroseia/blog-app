require 'rails_helper'

RSpec.describe 'Post Index Page', type: :feature do
  before(:each) do
    visit new_user_session_path
    fill_in 'Email', with: 'lily@gmail.com'
    fill_in 'Password', with: 'lily12345'
    click_button('Log in')
    @user = User.find(3)
    visit user_posts_path(@user.id)
  end

  it 'has profile picture' do
    expect(page).to have_css('img')
  end

  it 'has the name of the user' do
    expect(page).to have_content(@user.name)
  end

  it 'displays number of posts' do
    expect(page).to have_content("number of posts: #{@user.posts_counter}")
  end

  it 'displays the posts title' do
    posts = @user.posts
    posts.each { |post| expect(page).to have_content(post.title) }
    count = page.all('li.post-data').size
    expect(posts.length).to eq(count / 2)
  end

  it 'displays some of the content fo the post' do
    post = @user.posts.take
    expect(page).to have_content(post.text[0...47])
  end

  it 'displays the number of comments' do
    post = @user.posts.take
    expect(page).to have_content("Comments: #{post.comments_counter}")
  end

  it 'displays the number of likes' do
    post = @user.posts.take
    expect(page).to have_content("likes: #{post.likes_counter}")
  end

  it 'link button redirects to post show page' do
    post = @user.posts.take
    click_link('See Post', href: user_post_path(@user.id, post.id))
    expect(current_path).to eql(user_post_path(@user.id, post.id))
  end
end
