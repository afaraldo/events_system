require 'rails_helper'

RSpec.describe "events/edit", type: :view do
  let(:event) {
    Event.create!(
      name: "MyString",
      description: "MyString",
      organizer: "MyString",
      status: "MyString",
      user: create(:user)
    )
  }

  before(:each) do
    assign(:event, event)
  end

  it "renders the edit event form" do
    render

    assert_select "form[action=?][method=?]", event_path(event), "post" do

      assert_select "input[name=?]", "event[name]"

      assert_select "input[name=?]", "event[description]"

      assert_select "input[name=?]", "event[organizer]"

      assert_select "input[name=?]", "event[status]"
    end
  end
end
