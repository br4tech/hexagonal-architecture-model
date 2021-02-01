FactoryBot.define do
  factory :payroll do
    emission { Faker::Date.in_date_period(year: 2020, month: 1) }  
    amount { 5 }   
    client
    due_at { Faker::Date.in_date_period(year: 2020, month: 1) }
    ends_at { Faker::Date.in_date_period(year: 2020, month: 1) }
    
    after(:create) do | payroll |      
      create_list(:payroll_item,5, payroll: payroll, office_id: 1 ) 
    end  
  end
end
