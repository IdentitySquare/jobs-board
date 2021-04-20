require 'rails_helper'

RSpec.describe '/companies', type: :request do
  describe 'company path' do
    it 'renders a successful response for index' do
      get companies_path

      expect(response).to have_http_status(:success)
    end

    it 'renders a successful response for show' do
      user = create(:user)
      company = create(:company, user_id: user.id)
      get "/companies/#{company.id}"

      expect(response).to have_http_status(:success)
    end

    it 'renders a 302 response for edit' do
      user = create(:user)
      company = create(:company, user_id: user.id)
      get "/companies/#{company.id}/edit"

      expect(response).to have_http_status(302)
    end
  end

  describe 'does not allow guest', type: :request do
    it 'to delete companies' do
      user = create(:user)
      company = create(:company, user_id: user.id)
      delete "/companies/#{company.id}"

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
