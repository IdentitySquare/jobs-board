require 'rails_helper'

RSpec.describe Job, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:job_type) }

  describe 'company creation specs' do
    it 'should be able to save job only with a user who the ocmpany belongs to' do
      user = build(:user)
      user.save!
      company = build(:company, user_id: user.id)
      company.save!
      job = build(:job, company_id: company.id)

      expect(job.save).to eq(true)
    end

    it 'should not be able to save company without a user' do
      job = build(:job, company_id: 1)

      expect(job.save).to eq(false)
    end
  end
end
