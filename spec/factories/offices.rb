# frozen_string_literal: true

FactoryBot.define do
  factory :office do
    name    { Faker::Company.name  }
    code    { 'PRONTO' }
    address { 'Rua dos Bobos, 0' }
    phone   { Faker::PhoneNumber.phone_number }
    phone_secondary { Faker::PhoneNumber.phone_number }
    status { 0 }
    opening_hours { 'Seg a Sex das 8h as 18h, Sábado das 8h as 12h' }
    start_at { 8 }
    end_at { 17 }
  end
end
