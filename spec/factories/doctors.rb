# frozen_string_literal: true

FactoryBot.define do
    factory :doctor do
    crm  { Faker::Number.number(digits: 4) } 

    after(:create) do |doctor|
      create(:expertise, doctor_id: doctor.id )
      create(:medical_info, doctor_id: doctor.id )
    end
  end
end
