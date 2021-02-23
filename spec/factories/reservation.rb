FactoryBot.define do
  factory :reservation do
    client
    date { Faker::Date.between(from: 20.days.ago, to: Date.today)  }
    clinic
  end
end
