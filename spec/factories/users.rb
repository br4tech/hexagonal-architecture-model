# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'change-me' }
  end

  trait :admin do
    role { 0 } # Admin
  end

  trait :manager do
    role { 1 }
  end

  trait :secretary do
    role { 2 }
  end
end
