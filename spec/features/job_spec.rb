require 'rails_helper'

describe 'does not allows guests', type: :feature do
  let(:user) { create(:user) }
  let(:company) { create(:company, user_id: user.id) }
  let(:job) { create(:job, company_id: company.id) }

  it 'to create a new job' do
    visit "/companies/#{company.id}/jobs/new"

    expect(page).to have_text('Action not authorized!')
    expect(current_path).to eq(root_path)
  end

  it 'to edit companies' do
    visit "/companies/#{company.id}/jobs/#{job.id}/edit"

    expect(page).to have_text('Action not authorized!')
    expect(current_path).to eq(root_path)
  end
end

describe 'does not allow a different user', type: :feature do
  let(:user) { create(:user) }
  let(:user2) { create(:user, email: 'jake2@gmail.com') }
  let(:company) { create(:company, user_id: user.id) }
  let(:job) { create(:job, company_id: company.id) }

  it "edit a company that doesn't belong to " do
    visit new_user_session_path
    fill_in 'Email', with: 'jake2@gmail.com'
    fill_in 'Password', with: 'password'
    find('input[name="commit"]').click
    visit "/companies/#{company.id}/jobs/#{job.id}/edit"

    expect(page).to have_text('Action not authorized!')
    expect(current_path).to eq(root_path)
  end
end

describe 'allows users', type: :feature do
  before :each do
    Capybara.current_driver = :selenium
    @user = create(:user)
    @company = create(:company, user_id: @user.id)
    @job = create(:job, company_id: @company.id)
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    find('input[name="commit"]').click
  end

  it 'to create new jobs' do
    visit "/companies/#{@company.id}/jobs/new"
    fill_in 'Title', with: 'test job'
    find('trix-editor').set('testing 123456')
    find('input[name="commit"]').click

    expect(page).to have_text('Job was successfully created.')
    expect(current_path).to eq("/companies.#{@company.id}")
  end

  it 'to delete their jobs' do
    visit "/companies/#{@company.id}/jobs/new"
    fill_in 'Title', with: 'test job'
    find('trix-editor').set('testing 123456')
    find('input[name="commit"]').click
    visit "/companies/#{@company.id}/jobs/#{@job.id}"
    click_link 'Delete'
    page.driver.browser.switch_to.alert.accept

    expect(page).to have_text('Job was successfully destroyed.')
    expect(current_path).to eq("/companies.#{@company.id}")
  end

  it 'to edit their jobs' do
    visit "/companies/#{@company.id}/jobs/#{@job.id}/edit"
    fill_in 'Title', with: 'test job'
    find('trix-editor').set('testing 123456')
    find('input[name="commit"]').click

    expect(page).to have_text('Job was successfully updated.')
    expect(current_path).to eq("/companies/#{@company.id}")
  end

  after :all do
    Capybara.use_default_driver
  end
end
