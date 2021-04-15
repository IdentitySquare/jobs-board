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
    let(:user) { build(:user) }
    let(:user2) { build(:user) }
    let(:company) { build(:company, user_id: user.id) }

    it 'grants edit, create or delete access only to owner of company' do
      user.save!

      expect(subject).to permit(user, company)
    end

    it 'does not grant edit, create or delete access to other users' do
      user2.save!

      expect(subject).to_not permit(user2, company)
    end

    it 'does not grant edit, create or delete access to guest' do
      user.save!

      expect(subject).to_not permit(nil, company)
    end
  end
end
