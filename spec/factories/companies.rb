FactoryBot.define do
  factory :company do    
    wallet {  Faker::Bank.account_number(digits: 2) }   
    digit { Faker::Bank.account_number(digits: 1) }
    company_code { Faker::Bank.account_number(digits: 4) }
    shipping_sequence { Faker::Bank.account_number(digits: 4) }
    zipcode {"01423-000"}    
    state { "SP"}
  
    trait :pronto do
      name { "PRONTO CONSULTORIO SOLUCOES MEDICAS LTDA."}
      document { "30.052.905/0001-76" }       
      city {"São Paulo"}
      neighborhood {"Liberdade"}
      address {"R Maestro Cardim, 592 5o andar"}  
      wallet { 9 }
      agency {"0133"}
      current_account { "6627-3" }
      category { 0 }
      company_code { 5026911 }
    end

    trait :density do
      name { "DENSITY EMPREENDIMENTOS IMOBILIÁRIOS LTDA."}
      document {"12.940.625/0001-12"}
      city {"São Paulo"}
      neighborhood {"Jardim Paulista"}
      address {"Rua José Maria Lisboa 368, cj. 172 "}
      wallet { 9 }
      agency {"0133"}
      current_account { "5527-1" }
      category { 1 }
      company_code { 7902289 }
    end
  end
end
