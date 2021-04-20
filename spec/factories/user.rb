FactoryBot.define do
  password = Faker::Internet.password(min_length: 8)
  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { password }
    password_confirmation { password }
    confirmed_at { DateTime.now }
  end
end
