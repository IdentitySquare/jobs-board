require 'rails_helper'

RSpec.describe '/users/password', type: :request do
  describe 'passwords path' do
    it 'returns 302 response to edit' do
      get "/users/password/edit"

      expect(response).to have_http_status(302)
    end

    it 'returns success response to new (forgot password)' do
      get "/users/password/new"

      expect(response).to have_http_status(:success)
    end
end
