require 'rails_helper'

RSpec.describe 'Users Index Page', type: :feature do
  before(:each) do
    visit new_user_session_path
    fill_in 'Email', with: 'lily@gmail.com'
    fill_in 'Password', with: 'lily12345'
    click_button('Log in')
    @user = User.find(3)
    visit users_path
  end

  it 'has all users from db' do
    users = User.all
    users.each { |user| expect(page).to have_content(user.name) }
  end

  it 'users cards has images' do
    expect(page).to have_css('img')
  end

  it 'displays number of posts' do
    user = User.take
    expect(page).to have_content("number of posts: #{user.posts_counter}")
  end

  it 'redirects when you click user card' do
    user = User.take
    click_link(user.name)
    expect(current_path).to eql(user_path(user.id))
  end
end