require 'rails_helper'

RSpec.describe "attendees/new", type: :view do
  before(:each) do
    assign(:attendee, Attendee.new(
      name: "MyString",
      email: "MyString",
      event: nil
    ))
  end

  it "renders new attendee form" do
    render

    assert_select "form[action=?][method=?]", attendees_path, "post" do

      assert_select "input[name=?]", "attendee[name]"

      assert_select "input[name=?]", "attendee[email]"

      assert_select "input[name=?]", "attendee[event_id]"
    end
  end
end
