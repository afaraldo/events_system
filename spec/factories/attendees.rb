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
FactoryBot.define do
  factory :attendee do
    name { "MyString" }
    email { "MyString" }
    event { nil }
  end
end
