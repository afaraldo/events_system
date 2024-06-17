require 'rails_helper'

RSpec.describe "events/show", type: :view do
  before(:each) do
    assign(:event, create(:event))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Organizer/)
    expect(rendered).to match(/Status/)
  end
end
