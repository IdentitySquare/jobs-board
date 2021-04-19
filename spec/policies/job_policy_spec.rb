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
    let(:user) { create(:user, id: 1) }
    let(:company) { create(:company, user_id: user.id, id: 1) }
    let(:job) { create(:job, company_id: company.id) }
    let(:user2) { create(:user, id: 2) }

    it 'grants edit, create or delete access only to owner of company' do
      expect(subject).to permit(user, job)
    end

    it 'does not grant edit, create or delete access to other users' do
      expect(subject).to_not permit(user2, job)
    end

    it 'does not grant edit, create or delete access to guest' do
      expect(subject).to_not permit(nil, job)
    end
  end
end
