require 'rails_helper'

RSpec.describe 'attendees/new', type: :view do
  before(:each) do
    assign(:attendee, build(:attendee))
  end

  it 'renders new attendee form' do
    render

    assert_select 'form[action=?][method=?]', attendees_path, 'post' do
      assert_select 'input[name=?]', 'attendee[name]'
      assert_select 'input[name=?]', 'attendee[email]'
    end
  end
end
