require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:password) }
end

context 'extra tests' do
  it 'ensures user is valid only if both passwords match' do
    user = build(:user, password: 'password', password_confirmation: 'password1')

    expect(user.valid?).to eq(false)
  end

  it 'should be able to save user' do
    user = build(:user)

    expect(user.save).to eq(true)
  end
end
