require 'rails_helper'

RSpec.describe 'attendees/index', type: :view do
  before(:each) do
    assign(:attendees, [
             create(:attendee),
             create(:attendee)
           ])
  end

  it 'renders a list of attendees' do
    skip('Add assertions for attendees/index.html.erb')
  end
end
