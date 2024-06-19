require 'rails_helper'

RSpec.describe 'Sessions API', type: :request do
  let(:user) { create(:user) }
  let(:valid_credentials) do
    {
      user: {
        email: user.email,
        password: user.password
      }
    }.as_json
  end
  let(:invalid_credentials) do
    {
      user: {
        email: user.email,
        password: 'wrongpassword'
      }
    }.as_json
  end

  describe 'POST /api/v1/login' do
    context 'when the request is valid' do
      before { post '/api/v1/login', params: valid_credentials }

      it 'returns a success message' do
        expect(response.parsed_body['message']).to match(/Logged in successfully/)
      end

      it 'returns a user' do
        expect(response.parsed_body['user']).not_to be_nil
      end

      it 'returns a JWT token' do
        expect(response.parsed_body['token']).not_to be_nil
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/login', params: invalid_credentials }

      it 'returns a failure message' do
        expect(response.body).to match(/Invalid Email or password/)
      end

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'DELETE /api/v1/logout' do
    before do
      post '/api/v1/login', params: valid_credentials
      @token = response.parsed_body['token']
      delete '/api/v1/logout', headers: { 'Authorization' => "Bearer #{@token}" }
    end

    it 'returns a success message' do
      expect(response.parsed_body['message']).to match(/Logged out successfully/)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
