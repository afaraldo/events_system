require 'rails_helper'

RSpec.describe "attendees/index", type: :view do
  before(:each) do
    assign(:attendees, [
      Attendee.create!(
        name: "Name",
        email: "Email",
        event: nil
      ),
      Attendee.create!(
        name: "Name",
        email: "Email",
        event: nil
      )
    ])
  end

  it "renders a list of attendees" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Email".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
