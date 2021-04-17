require 'rails_helper'
require 'pundit/rspec'

RSpec.describe JobPolicy, type: :policy do
  subject { JobPolicy }

  permissions :show? do
    it 'grants access to visitors' do
      expect(subject).to permit(nil, Job.new)
    end
  end

  permissions :edit?, :create?, :update?, :destroy? do
    let(:user) { build(:user) }
    let(:user2) { build(:user) }
    let(:company) { build(:company, user_id: user.id) }
    let(:job) { build(:job, company_id: company.id) }

    it 'grants edit, create or delete access only to owner of company' do
      user.save!
      company.save!

      expect(subject).to permit(user, job)
    end

    it 'does not grant edit, create or delete access to other users' do
      user.save!
      company.save!

      expect(subject).to_not permit(user2, job)
    end

    it 'does not grant edit, create or delete access to guest' do
      user.save!
      company.save!

      expect(subject).to_not permit(nil, job)
    end
  end
end
