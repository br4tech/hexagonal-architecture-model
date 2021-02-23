FactoryBot.define do
  factory :person do
    people_kind { nil }
    name { "MyString" }
    email { "MyString" }
    phone { "MyString" }
    status { false }
  end
end
