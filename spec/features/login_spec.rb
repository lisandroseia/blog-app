require 'rails_helper'

RSpec.describe 'Login_page', type: :feature do
  before(:each) do
    visit new_user_session_path
  end

  it 'has correct inputs' do
    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
    expect(page).to have_button('Log in')
  end

  it 'gives error if fields are unfilled' do
    click_button('Log in')
    expect(page).to have_content('Invalid Email or password.')
  end

  it 'gives error if submit button pressed with invalid user' do
    fill_in 'Email', with: 'hi'
    fill_in 'Password', with: 'bye'
    click_button('Log in')
    expect(page).to have_content('Invalid Email or password.')
  end

  it 'goes to root if loged in' do
    fill_in 'Email', with: 'lily@gmail.com'
    fill_in 'Password', with: 'lily12345'
    click_button('Log in')
    expect(page).to have_content('Signed in successfully.')
    expect(current_path).to eql(root_path)
  end
end