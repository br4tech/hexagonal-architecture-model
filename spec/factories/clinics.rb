# frozen_string_literal: true

FactoryBot.define do
  factory :clinic do  
    sequence(:code, 99) { |n| "0#{n}" }
    association :office 
    status { 1 }
    price { 20.0 }
    metrics { '50x50m' }
    medical_specialties { 'Oftalmo' }
    color { Faker::Color.hex_color }
  end
end
