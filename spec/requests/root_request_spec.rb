require 'rails_helper'

describe 'root', type: :request do
  context 'send get request to root path' do
    it 'returns a success response' do
      get root_path

      expect(response).to have_http_status(:success)
    end
  end
end
