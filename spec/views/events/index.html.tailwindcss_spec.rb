# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'events/index', type: :view do
  before(:each) do
    assign(:events, [
             create(:event),
             create(:event)
           ])
  end

  it 'renders a list of events' do
    skip('Add assertions for events/index.html.erb')
  end
end
