FactoryBot.define do
  factory :contract do   
    association :hirer, factory: :doctor
    starts_at { "2019-11-01 11:08:25" }
    ends_at { "2020-11-01 11:08:25" }
    amount { 189.99 }
    revenues_at { 20 }
    due_at { 01 }
    forfeit { 1999.99 }
    kind { 1 }
    rescheduling_allowed { 10 }
    parking { false }
    car_license_plate { nil }
    kind_people { 1 }

    after(:create) do |contract|
      create(:discount, contract_id: contract.id)
    end

    trait :pronto do
      category {0}
      after(:create) do |contract|
        create(:attendance, :pronto, contract_id: contract.id )
      end
    end

    trait :density do
      category {1}
      after(:create) do |contract|
        create(:attendance, :density, contract_id: contract.id )
      end
    end
  end
end
