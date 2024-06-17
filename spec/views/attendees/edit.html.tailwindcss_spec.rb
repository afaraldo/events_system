require 'rails_helper'

RSpec.describe 'attendees/edit', type: :view do
  let(:attendee) do
    Attendee.create!(
      name: 'MyString',
      email: 'MyString'
    )
  end

  before(:each) do
    assign(:attendee, attendee)
  end

  it 'renders the edit attendee form' do
    render

    assert_select 'form[action=?][method=?]', attendee_path(attendee), 'post' do
      assert_select 'input[name=?]', 'attendee[name]'
      assert_select 'input[name=?]', 'attendee[email]'
    end
  end
end
