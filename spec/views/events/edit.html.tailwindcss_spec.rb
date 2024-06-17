require 'rails_helper'

RSpec.describe 'events/edit', type: :view do
  let(:event) do
    create(:event)
  end

  before(:each) do
    assign(:event, event)
  end

  it 'renders the edit event form' do
    render

    assert_select 'form[action=?][method=?]', event_path(event), 'post' do
      assert_select 'input[name=?]', 'event[name]'
      assert_select 'input[name=?]', 'event[description]'
      assert_select 'input[name=?]', 'event[organizer]'
    end
  end
end
