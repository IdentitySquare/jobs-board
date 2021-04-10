require 'rails_helper'

describe 'registrations', type: :request do
  context 'send get requests to sessions path' do
    it 'sign in path returns a success response' do
      get new_user_session_path

      expect(response).to have_http_status(:success)
    end
  end
end
