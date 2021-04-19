require 'rails_helper'

RSpec.describe '/jobs', type: :request do
  describe 'jobs path' do
    it 'redirects index to the company show route' do
      user = create(:user)
      company = create(:company, user_id: user.id)
      get "/companies/#{company.id}/jobs"

      expect(response).to redirect_to("/companies/#{company.id}")
    end

    it 'returns success response for show' do
      user = create(:user)
      company = create(:company, user_id: user.id)
      job = create(:job, company_id: company.id)
      get "/companies/#{company.id}/jobs/#{job.id}"

      expect(response).to have_http_status(:success)
    end

    it 'returns 302 response for edit' do
      user = create(:user)
      company = create(:company, user_id: user.id)
      job = create(:job, company_id: company.id)
      get "/companies/#{company.id}/jobs/#{job.id}/edit"

      expect(response).to have_http_status(302)
    end
  end
end
