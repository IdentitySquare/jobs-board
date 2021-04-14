require 'rails_helper'
require 'pundit/rspec'

RSpec.describe CompanyPolicy, type: :policy do
  subject { CompanyPolicy }

  permissions :show? do
    it 'grants access to visitors' do
      expect(subject).to permit(build(:user), Company.new)
    end
  end

  permissions :create?, :update?, :destroy? do
    let(:user) { build(:user) }
    let(:company) { build(:company, user: user) }

    it 'grants access only to users who the company belongs to' do
      expect(subject).to permit(user, company)
    end

    it 'does not grant access to guests' do
      expect(subject).to_not permit(build(:user), Company.new)
    end
  end
end
