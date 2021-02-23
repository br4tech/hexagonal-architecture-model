FactoryBot.define do
  factory :reservation_without_contract do
    doctor { nil }
    time_start { "2020-04-17 10:46:46" }
    time_end { "2020-04-17 10:46:46" }
    date { "2020-04-17 10:46:46" }
    office { nil }
    clinic { nil }
  end
end
