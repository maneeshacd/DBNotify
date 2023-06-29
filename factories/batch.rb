FactoryBot.define do
  factory :batch do
    id { Faker::Number.number(digits: 2) }
    customer_id { Faker::Number.number(digits: 5) }
    customer_name { Faker::Name.name }
  end
end
