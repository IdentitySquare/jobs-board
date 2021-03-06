require 'rails_helper'

describe 'registrations', type: :request do
  context 'send get requests to registrations path' do
    it 'sign up path returns a success response' do
      get new_user_registration_path

      expect(response).to have_http_status(:success)
    end

    it 'edit path returns a 302 response' do
      get edit_user_registration_path

      expect(response).to have_http_status(302)
    end
  end
end
