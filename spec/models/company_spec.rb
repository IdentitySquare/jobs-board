require 'rails_helper'

RSpec.describe Company, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
end

describe 'company creation specs' do
  it 'should be able to save company only with a user present' do
    user = build(:user)
    user.save!
    company = build(:company, user_id: user.id)

    expect(company.save).to eq(true)
  end

  it 'should not be able to save company without a user' do
    company = build(:company, user_id: 1)

    expect(company.save).to eq(false)
  end
end
