require 'rails_helper'

describe 'the edit user details process', type: :feature do
  before :each do
    Capybara.current_driver = :selenium
    user = build(:user)
    user.save!
    visit new_user_session_path
    fill_in 'Email', with: 'jake@gmail.com'
    fill_in 'Password', with: 'password'
    find('input[name="commit"]').click
  end

  it 'edits the password' do
    visit edit_user_registration_path
    fill_in 'Password', with: 'password2'
    fill_in 'Password confirmation', with: 'password2'
    fill_in 'Current password', with: 'password'
    find('input[name="commit"]').click

    expect(current_path).to eq(root_path)
    expect(page).to have_text('Your account has been updated successfully.')
  end

  it 'edits the email' do
    visit edit_user_registration_path
    fill_in 'Email', with: 'jake2@gmail.com'
    fill_in 'Current password', with: 'password'
    find('input[name="commit"]').click

    expect(current_path).to eq(root_path)
    expect(page).to have_text('Your account has been updated successfully.')
    expect(User.last.email).to eq('jake2@gmail.com')
  end

  it 'edits the first name' do
    visit edit_user_registration_path
    fill_in 'First name', with: 'Jakes'
    fill_in 'Current password', with: 'password'
    find('input[name="commit"]').click

    expect(current_path).to eq(root_path)
    expect(page).to have_text('Your account has been updated successfully.')
    expect(User.last.first_name).to eq('Jakes')
  end

  it 'edits the last name' do
    visit edit_user_registration_path
    fill_in 'Last name', with: 'Smithsonian'
    fill_in 'Current password', with: 'password'
    find('input[name="commit"]').click

    expect(current_path).to eq(root_path)
    expect(page).to have_text('Your account has been updated successfully.')
    expect(User.last.last_name).to eq('Smithsonian')
  end

  it 'does not alter record if current password is not provided' do
    visit edit_user_registration_path
    fill_in 'First name', with: 'Jakes'
    fill_in 'Last name', with: 'Smithsonian'
    find('input[name="commit"]').click

    expect(page).to have_text("Current password can't be blank")
    expect(current_path).to eq(user_registration_path)
    expect(User.last.last_name).to eq('Doe')
    expect(User.last.first_name).to eq('John')
  end

  it 'deletes account' do
    visit edit_user_registration_path
    click_button 'Delete my account'
    page.driver.browser.switch_to.alert.accept

    expect(page).to have_text('Your account has been successfully deleted!')
    expect(current_path).to eq(root_path)
  end

  after :all do
    Capybara.use_default_driver
  end
end
