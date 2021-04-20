require 'rails_helper'
require 'pundit/rspec'

RSpec.describe CompanyPolicy, type: :policy do
  subject { CompanyPolicy }

  permissions :show? do
    it 'grants access to visitors' do
      expect(subject).to permit(nil, Company.new)
    end
  end

  permissions :edit?, :create?, :update?, :destroy? do
    let(:user) { create(:user) }
    let(:company) { create(:company, user_id: user.id) }
    let(:user2) { create(:user) }

    it 'grants edit, create or delete access only to owner of company' do
      expect(subject).to permit(user, company)
    end

    it 'does not grant edit, create or delete access to other users' do
      expect(subject).to_not permit(user2, company)
    end

    it 'does not grant edit, create or delete access to guest' do
      expect(subject).to_not permit(nil, company)
    end
  end
end
