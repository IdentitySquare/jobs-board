FactoryBot.define do
  factory :job do
    title { Faker::Job.title }
    description { Faker::Job.seniority + Faker::Job.field + Faker::Job.position }
    job_type { rand(0..1) }
  end
end
