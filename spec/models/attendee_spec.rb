# == Schema Information
#
# Table name: attendees
#
#  id         :bigint           not null, primary key
#  email      :string
#  name       :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_attendees_on_email  (email) UNIQUE
#
require 'rails_helper'

RSpec.describe Attendee, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
