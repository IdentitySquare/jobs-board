require 'rails_helper'

describe 'the token password reset process', type: :feature do
  it 'edits the password using reset token' do
    User.create(first_name: 'jake', last_name: 'smith', email: 'jake@gmail.com', password: 'password',
                password_confirmation: 'password')
    visit new_user_session_path
    click_link 'Forgot your password'
    expect(current_path).to eq(new_user_password_path)
    fill_in 'Email', with: 'jake@gmail.com'
    find('input[name="commit"]').click
    expect(page).to have_text('You will receive an email with instructions on how to reset your password in a few minutes.')
    expect(current_path).to eq(new_user_session_path)
    token = User.last.send_reset_password_instructions
    visit "http://localhost:3000/users/password/edit?reset_password_token=#{token}"
    fill_in 'New password', with: 'password2'
    fill_in 'Confirm new password', with: 'password2'
    find('input[name="commit"]').click
    expect(page).to have_text('Your password has been changed successfully. You are now signed in.')
    expect(current_path).to eq(root_path)
  end
end
