require 'rails_helper'

describe 'the edit user details process', type: :feature do
  before :each do
    Capybara.current_driver = :selenium
    User.create(first_name: 'jake', last_name: 'smith', email: 'jake@gmail.com', password: 'password',
                password_confirmation: 'password')
    visit new_user_session_path
    fill_in 'Email', with: 'jake@gmail.com'
    fill_in 'Password', with: 'password'
    find('input[name="commit"]').click
  end

  it 'edits the password' do
    visit edit_user_registration_path
    fill_in 'Email', with: 'jake@gmail.com'
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

  it 'deletes account' do
    visit edit_user_registration_path
    click_button 'Cancel my account'
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_text('Bye! Your account has been successfully cancelled. We hope to see you again soon.')
    expect(current_path).to eq(root_path)
  end

  after :all do
    Capybara.use_default_driver
  end
end
