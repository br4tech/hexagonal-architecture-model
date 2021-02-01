FactoryBot.define do
  factory :payroll_item do
    period { Faker::Date.in_date_period }
    clinic
    hours { Faker::Number.digit }
    amount { 5  }
    payroll
  end
end
