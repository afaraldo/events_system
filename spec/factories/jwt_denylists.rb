FactoryBot.define do
  factory :jwt_denylist do
    jti { 'MyString' }
    exp { '2024-06-19 09:45:43' }
  end
end
