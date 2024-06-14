# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'events/index', type: :view do
  before(:each) do
    assign(:events, [
             Event.create!(
               name: 'Name',
               description: 'Description',
               organizer: 'Organizer',
               status: 'Status',
               user: create(:user)
             ),
             Event.create!(
               name: 'Name',
               description: 'Description',
               organizer: 'Organizer',
               status: 'Status',
               user: create(:user)
             )
           ])
  end

  it 'renders a list of events' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Name'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Description'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Organizer'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Status'.to_s), count: 2
  end
end
