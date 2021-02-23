FactoryBot.define do
  factory :discount do
    amount { "9.99" }
    starts_at { "2019-11-08 00:09:45" }
    ends_at { "2019-11-08 00:09:45" }
    contract
  end
end
