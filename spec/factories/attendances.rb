FactoryBot.define do
  factory :attendance do  
    contract
    office
    clinic
    date_starts_at {Faker::Time.between(from: DateTime.now, to: DateTime.now)  }
    date_ends_at { Faker::Time.between(from: DateTime.now, to: DateTime.now)  }
    starts_at {Faker::Time.between(from: DateTime.now, to: DateTime.now)  }
    ends_at { Faker::Time.between(from: DateTime.now + 2.hours, to: DateTime.now)  }
    is_recurrent { false }
    frequency { 1}


    trait :density do
      weekdays {[1,3,4]}
    end

    trait :pronto do
      weekdays {[2,5]}
    end
  end
end
