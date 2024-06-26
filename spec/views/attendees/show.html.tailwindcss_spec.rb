require 'rails_helper'

RSpec.describe 'attendees/show', type: :view do
  before(:each) do
    assign(:attendee, create(:attendee))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(//)
  end
end
