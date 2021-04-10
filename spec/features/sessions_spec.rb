require 'rails_helper'

describe 'the signin process', type: :feature do
  before :each do
    visit new_user_registration_path
    fill_in 'Email', with: 'jake@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    fill_in 'First name', with: 'jake'
    fill_in 'Last name', with: 'smith'
    find('input[name="commit"]').click
    user = User.find_by_email 'jake@gmail.com'
    visit "users/confirmation?confirmation_token=#{user.confirmation_token}"
  end

  it 'signs @user in' do
    visit new_user_session_path
    fill_in 'Email', with: 'jake@gmail.com'
    fill_in 'Password', with: 'password'
    find('input[name="commit"]').click

    expect(current_path).to eq(root_path)
    expect(page).to have_text('Signed in successfully.')
    expect(User.last.email).to eq('jake@gmail.com')
  end

  it "throws error if password doesn't match with email in db" do
    visit new_user_session_path
    fill_in 'Email', with: 'jake@gmail.com'
    fill_in 'Password', with: 'password1'
    find('input[name="commit"]').click

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_text('Invalid Email or password')
  end

  it "throws error if user doesn't exist" do
    User.last.destroy
    visit new_user_session_path
    fill_in 'Email', with: 'jake1@gmail.com'
    fill_in 'Password', with: 'password'
    find('input[name="commit"]').click

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_text('Invalid Email or password')
    expect(User.last).to eq(nil)
  end

  it 'does not sign in if email is invalid format' do
    User.last.destroy
    visit new_user_session_path
    fill_in 'Email', with: 'invalid_email'
    fill_in 'Password', with: 'pass'
    find('input[name="commit"]').click

    expect(current_path).to eq(new_user_session_path)
    expect(User.last).to eq(nil)
  end
end
