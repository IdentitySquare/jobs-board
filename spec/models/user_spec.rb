require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations tests' do
    it 'ensures the email is present' do
      user = User.new(first_name: 'jake', last_name: 'smith', password: 'password', password_confirmation: 'password')
      expect(user.valid?).to eq(false)
    end

    it 'ensures the password is present' do
      user = User.new(first_name: 'jake', last_name: 'smith', email: 'jake@gmail.com')
      expect(user.valid?).to eq(false)
    end

    it 'ensures first and last names are present' do
      user = User.new(email: 'jake@gmail.com')
      expect(user.valid?).to eq(false)
    end

    it 'ensures user is valid only if first name, last name, email and password are present' do
      user = User.create(first_name: 'jake', last_name: 'smith', email: 'jake@gmail.com', password: 'password',
                         password_confirmation: 'password')
      expect(user.valid?).to eq(true)
    end

    it 'ensures user is valid only if both passwords match' do
      user = User.new(first_name: 'jake', last_name: 'smith', email: 'jake@gmail.com', password: 'password',
                      password_confirmation: 'password1')
      expect(user.valid?).to eq(false)
    end

    it 'should be able to save user' do
      user = User.new(first_name: 'jake', last_name: 'smith', email: 'jake@gmail.com', password: 'password',
                      password_confirmation: 'password')
      expect(user.save).to eq(true)
    end
  end
end
