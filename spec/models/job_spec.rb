require 'rails_helper'

RSpec.describe Job, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:job_type) }

  describe 'company creation specs' do
    it 'should be able to save job only with a user who the ocmpany belongs to' do
      user = create(:user)
      company = create(:company, user_id: user.id)
      job = build(:job, company_id: company.id)

      expect(job.save).to eq(true)
    end

    it 'should not be able to create a job as a guest' do
      job = build(:job)

      expect(job.save).to eq(false)
    end

    it "should not be able to create a job under a company owned by another user" do
      user = create(:user, id: 1)
      company = create(:company, user_id: 1)
      job = build(:job, company_id: 2)

      expect(job.save).to eq(false)
    end
  end
end
