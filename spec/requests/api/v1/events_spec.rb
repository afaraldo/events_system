require 'rails_helper'

RSpec.describe 'Events API', type: :request do
  let(:user) { create(:user) }
  let!(:events) { create_list(:event, 10, user:) }
  let(:event_id) { events.first.id }
  let(:headers) { valid_headers }

  before do
    sign_in user
  end

  def token_generator(user)
    Warden::JWTAuth::UserEncoder.new.call(user, :user, nil)
  end

  def valid_headers
    {
      'Authorization' => "Bearer #{token_generator(user)[0]}",
      'Content-Type' => 'application/json'
    }
  end

  describe 'GET /api/v1/events' do
    before { get '/api/v1/events', headers: }

    it 'returns events' do
      expect(response.parsed_body['events']).not_to be_empty
      expect(response.parsed_body['events'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/events/:id' do
    before { get "/api/v1/events/#{event_id}", headers: }

    context 'when the record exists' do
      it 'returns the event' do
        expect(response.parsed_body).not_to be_empty
        expect(response.parsed_body['id']).to eq(event_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:event_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Event/)
      end
    end
  end

  describe 'POST /api/v1/events' do
    let(:valid_attributes) { { event: { description: 'Learn Elm', end_time: 2.days.from_now, name: 'Elm Meetup', organizer: user.email, start_time: 1.day.from_now, status: 'planned' } }.to_json }

    context 'when the request is valid' do
      before { post '/api/v1/events', params: valid_attributes, headers: }

      it 'creates an event' do
        expect(response.parsed_body['name']).to eq('Elm Meetup')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/events', params: { event: { name: '' } }.to_json, headers: }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /api/v1/events/:id' do
    let(:valid_attributes) { { event: { name: 'Shopping' } }.to_json }

    context 'when the record exists' do
      before { put "/api/v1/events/#{event_id}", params: valid_attributes, headers: }

      it 'updates the record' do
        expect(response.parsed_body['name']).to eq('Shopping')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE /api/v1/events/:id' do
    before { delete "/api/v1/events/#{event_id}", headers: }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
