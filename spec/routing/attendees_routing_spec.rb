require 'rails_helper'

RSpec.describe AttendeesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/attendees').to route_to('attendees#index')
    end

    it 'routes to #new' do
      expect(get: '/attendees/new').to route_to('attendees#new')
    end

    it 'routes to #show' do
      expect(get: '/attendees/1').to route_to('attendees#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/attendees/1/edit').to route_to('attendees#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/attendees').to route_to('attendees#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/attendees/1').to route_to('attendees#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/attendees/1').to route_to('attendees#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/attendees/1').to route_to('attendees#destroy', id: '1')
    end
  end
end
