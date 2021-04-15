require 'rails_helper'

describe 'does not allows guests', type: :feature do
  it 'to create a new company' do
    visit new_company_path

    expect(page).to have_text('You need to sign in or sign up before continuing.')
    expect(current_path).to eq(new_user_session_path)
  end

  it 'to edit companies' do
    user = build(:user)
    user.save!
    company = build(:company, user_id: user.id)
    company.save!
    visit "/companies/#{company.id}/edit"

    expect(page).to have_text('You need to sign in or sign up before continuing.')
    expect(current_path).to eq(new_user_session_path)
  end
end

describe 'does not allow a different user', type: :feature do
  it "edit a company that doesn't belong to " do
    user = build(:user)
    user.save!
    company = build(:company, user_id: user.id)
    company.save!
    user2 = build(:user, email: 'jake2@gmail.com')
    user2.save!
    visit new_user_session_path
    fill_in 'Email', with: 'jake2@gmail.com'
    fill_in 'Password', with: 'password'
    find('input[name="commit"]').click
    visit "/companies/#{company.id}/edit"

    expect(page).to have_text('Action not authorized!')
    expect(current_path).to eq(root_path)
  end
end

describe 'allows users', type: :feature do
  before :each do
    Capybara.current_driver = :selenium
    user = build(:user)
    user.save!
    visit new_user_session_path
    fill_in 'Email', with: 'jake@gmail.com'
    fill_in 'Password', with: 'password'
    find('input[name="commit"]').click
    visit new_company_path
  end

  it 'to create a new company' do
    fill_in 'Name', with: 'test company'
    fill_in 'Description', with: 'test description'
    find('input[name="commit"]').click

    expect(page).to have_text('Company was successfully created.')
    expect(current_path).to eq("/companies/#{Company.last.id}")
  end

  it 'to delete their company' do
    fill_in 'Name', with: 'test company'
    fill_in 'Description', with: 'test description'
    find('input[name="commit"]').click
    visit "/companies/#{Company.last.id}"
    click_link 'Delete'
    page.driver.browser.switch_to.alert.accept

    expect(page).to have_text('Company was successfully destroyed.')
    expect(current_path).to eq(companies_path)
  end

  it 'to edit their company' do
    fill_in 'Name', with: 'test company'
    fill_in 'Description', with: 'test description'
    find('input[name="commit"]').click
    visit "/companies/#{Company.last.id}"
    click_link 'Edit'
    fill_in 'Name', with: 'edited'
    find('input[name="commit"]').click

    expect(page).to have_text('Company was successfully updated.')
    expect(current_path).to eq("/companies/#{Company.last.id}")
  end

  after :all do
    Capybara.use_default_driver
  end
end
