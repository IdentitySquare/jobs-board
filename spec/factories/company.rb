FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    description do
      Faker::Company.industry + Faker::Company.catch_phrase +
        Faker::Company.buzzword + Faker::Company.bs + Faker::Company.logo
    end
  end
end
