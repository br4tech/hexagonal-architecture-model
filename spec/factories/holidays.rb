FactoryBot.define do
  factory :holiday do

    trait :NewYear do
      name { "Ano Novo" }
      color {Faker::Color.hex_color}
      starts_at { "2020-01-01 00:00:00" }
      ends_at { "2020-01-01 23:59:00" }
    end

    trait :Carnival do
      name { "Carnaval"}
      color {Faker::Color.hex_color}
      starts_at { "2020-02-24 00:00:00" }
      ends_at { "2020-02-26 23:59:00" }
    end

    trait :GoodFriday do
      name { "Sexta-Feira Santa" }
      color {Faker::Color.hex_color}
      starts_at { "2020-04-10 00:00:00" }
      ends_at { "2020-04-10 23:59:00" }
    end

    trait :TiradentesDay do
      name { "Dia de Tiradentes" }
      color {Faker::Color.hex_color}
      starts_at { "2020-04-21 00:00:00" }
      ends_at { "2020-04-21 23:59:00" }
    end

    trait :LaborDay do
      name { "Dia do Trabalho" }
      color {Faker::Color.hex_color}
      starts_at { "2020-04-21 00:00:00" }
      ends_at { "2020-04-21 23:59:00" }
    end

    trait :CorpusChristi do
      name { "Corpus Christi" }
      color {Faker::Color.hex_color}
      starts_at { "2020-06-11 00:00:00" }
      ends_at { "2020-06-11 23:59:00" }
    end


    trait :IndependenceOfBrazil do
      name { "Independência do Brasil" }
      color {Faker::Color.hex_color}
      starts_at { "2020-09-07 00:00:00" }
      ends_at { "2020-09-07 23:59:00" }
    end

    trait :ConstitutionalistRevolution do
      name { "Consciência Negra" }
      color {Faker::Color.hex_color}
      starts_at { "2020-10-02 00:00:00" }
      ends_at { "2020-10-02 23:59:00" }
    end

    trait :LadyOfAparecid do
      name { "Nossa Senhora Aparecida" }
      color {Faker::Color.hex_color}
      starts_at { "2020-10-12 00:00:00" }
      ends_at { "2020-10-12 23:59:00" }
    end

    trait :BlackConsciousness do
      name { "Consciência Negra" }
      color {Faker::Color.hex_color}
      starts_at { "2020-11-21 00:00:00" }
      ends_at { "2020-11-21 23:59:00" }
    end

    trait :DayOfDead do
      name { "Dia de Finados" }
      color {Faker::Color.hex_color}
      starts_at { "2020-11-02 00:00:00" }
      ends_at { "2020-11-02 23:59:00" }
    end

    trait :ProclamationOftheRepublic do
      name { "Proclamação da República" }
      color {Faker::Color.hex_color}
      starts_at { "2020-11-15 00:00:00" }
      ends_at { "2020-11-15 23:59:00" }
    end

    trait :Christmas do
      name { "Natal" }
      color {Faker::Color.hex_color}
      starts_at { "2020-12-25 00:00:00" }
      ends_at { "2020-12-25 23:59:00" }
    end
  end
end
