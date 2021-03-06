require 'rails_helper'

describe 'the sign up process', type: :feature do
  before :each do
    visit new_user_registration_path
  end

  it 'creates a new user' do
    fill_in 'Email', with: 'jake@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    fill_in 'First name', with: 'jake'
    fill_in 'Last name', with: 'smith'
    find('input[name="commit"]').click

    expect(current_path).to eq(root_path)
    expect(page).to have_text('A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.')

    token = User.last.confirmation_token
    visit "/users/confirmation?confirmation_token=#{token}"

    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_text('Your email address has been successfully confirmed.')
  end

  it "doesn't create user if first name and last name are missing" do
    fill_in 'Email', with: 'jake@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    find('input[name="commit"]').click

    expect(current_path).to eq(user_registration_path)
    expect(page).to have_text("First name can't be blank")
    expect(page).to have_text("Last name can't be blank")
  end

  it "doesn't create user if email is missing" do
    fill_in 'First name', with: 'jake'
    fill_in 'Last name', with: 'smith'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    find('input[name="commit"]').click

    expect(page).to have_text("Email can't be blank")
    expect(current_path).to eq(user_registration_path)
  end

  it "doesn't create user if passwords don't match" do
    fill_in 'Email', with: 'jake1@gmail.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password1'
    fill_in 'First name', with: 'jake'
    fill_in 'Last name', with: 'smith'
    find('input[name="commit"]').click

    expect(current_path).to eq(user_registration_path)
    expect(page).to have_text("Password confirmation doesn't match Password")
  end
end
