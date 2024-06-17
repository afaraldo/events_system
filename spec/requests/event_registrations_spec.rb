require 'rails_helper'

RSpec.describe 'EventRegistrations', type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET /index' do
    pending "add some examples (or delete) #{__FILE__}"
  end
end
