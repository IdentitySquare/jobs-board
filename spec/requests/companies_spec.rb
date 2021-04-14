require 'rails_helper'

RSpec.describe '/companies', type: :request do
  describe 'GET /index' do
    it 'renders a successful response' do
      get companies_path

      expect(response).to have_http_status(:success)
    end
  end
end
