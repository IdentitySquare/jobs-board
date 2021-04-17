require 'rails_helper'

RSpec.describe '/companies', type: :request do
  describe 'company path' do
    it 'renders a successful response' do
      get companies_path

      expect(response).to have_http_status(:success)
    end
  end

  describe 'does not allow guest', type: :request do
    it 'to delete companies' do
      user = build(:user)
      user.save!
      company = build(:company, user_id: user.id)
      company.save!
      delete "/companies/#{company.id}"

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
