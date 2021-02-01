# frozen_string_literal: true

FactoryBot.define do
  factory :expertise do
    doctor
    name { 'Ortopedista' }
    duration { '45 minutos' }
    price { 150.0 }
    days_to_return { 30 }
    returns { true }
    confirm { false }
    observations { Faker::Quote.yoda }
  end
end
