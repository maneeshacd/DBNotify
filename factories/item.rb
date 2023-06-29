FactoryBot.define do
  factory :item do
    association :batch, factory: :batch

    id { Faker::Number.number(digits: 2) }
    quantity { Faker::Number.number(digits: 1) }
    name { Faker::Name.name }
  end
end
