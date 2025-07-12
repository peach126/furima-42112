FactoryBot.define do
  factory :order_shipping do
    token          { 'tok_abcdefghijk00000000000000000' }
    postal_code    { "#{rand(100..999)}-#{rand(1000..9999)}" }
    prefecture_id  { Faker::Number.between(from: 2, to: 48) }
    city           { Faker::Address.city }
    address        { Faker::Address.street_address }
    building       { Faker::Address.secondary_address }
    phone_number   { Faker::Number.leading_zero_number(digits: 11) }
  end
end
