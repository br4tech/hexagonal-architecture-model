# frozen_string_literal: true
require 'faker'
require 'factory_bot'


admin_gok  = User.find_or_create_by(name: 'Admin', email: 'admin@kanamobi.com.br', role: 0)
admin_gok .password = 'prontopass'
admin_gok .save

admin = User.find_or_create_by(name: 'Juliana', email: 'juliana@prontoconsultorios.com.br', role: 0)
admin.password = 'prontopass'
admin.save

secretary_maestro_01 = User.find_or_create_by(name: 'Secretaria Maestro Cardim 01', email: 'atendimento@prontoconsultorios.com.br', role: 2)
secretary_maestro_01.password = 'prontopass'
secretary_maestro_01.save

secretary_maestro_02 = User.find_or_create_by(name: 'Secretaria Maestro Cardim 02', email: 'maestrocardim@prontoconsultorios.com.br', role: 2)
secretary_maestro_02.password = 'prontopass'
secretary_maestro_02.save

secretary_pamplona_01 = User.find_or_create_by(name: 'Secretaria Pamplona 01', email: 'pamplona@prontoconsultorios.com.br', role: 2)
secretary_pamplona_01.password = 'prontopass'
secretary_pamplona_01.save

secretary_pamplona_02 = User.find_or_create_by(name: 'Secretaria Pamplona 02', email: 'recepção_pamplona@prontoconsultorios.com.br', role: 2)
secretary_pamplona_02 .password = 'prontopass'
secretary_pamplona_02.save

secretary_veiga_01  = User.find_or_create_by(name: 'Secretaria Veiga Filho 01', email: 'veigafilho@prontoconsultorios.com.br', role: 2)
secretary_veiga_01.password = 'prontopass'
secretary_veiga_01.save

secretary_veiga_02  = User.find_or_create_by(name: 'Secretaria Veiga Filho 02', email: 'higienopolis@prontoconsultorios.com.br', role: 2)
secretary_veiga_02.password = 'prontopass'
secretary_veiga_02.save

secretary_cardeal_01 = User.find_or_create_by(name: 'Secretaria Cardeal 01', email: 'pinheiros@prontoconsultorios.com.br', role: 2)
secretary_cardeal_01.password = 'prontopass'
secretary_cardeal_01.save

secretary_cardeal_02 = User.find_or_create_by(name: 'Secretaria Cardeal 02', email: 'cardealarcoverde@prontoconsultoros.com.br', role: 2)
secretary_cardeal_02.password = 'prontopass'
secretary_cardeal_02.save

physical_person = PersonKind.find_or_create_by(description: "Pessoa Fisica")
physical_person.save

legal_person = PersonKind.find_or_create_by(description: "Pessoa Juridica")
legal_person.save

opening_hours = 'Seg a Sex das 8h as 18h, Sábado das 8h as 12h'
start_at = Date.today + 8.hours
end_at = Date.today + 21.hours
weekdays = [1,2,3,4,5]

maestro = Office.find_or_create_by(
  name: 'Maestro Cardim', 
  code: 'MC', 
  opening_hours: opening_hours, 
  start_at: start_at, 
  end_at: end_at,
  weekdays: weekdays)

Access.find_or_create_by(
  user_id: admin.id,
  office_id: maestro.id,
  allow: true,
)

Access.find_or_create_by(
  user_id: secretary_maestro_01.id,
  office_id: maestro.id,
  allow: true
)

Access.find_or_create_by(
  user_id: secretary_maestro_02.id,
  office_id: maestro.id,
  allow: true
)

11.times do |i|
  Clinic.find_or_create_by(
    office_id: maestro.id,
    code: "Sala #{i + 1}",
    color: "#c3e8cc"
  )
end

pamplona = Office.find_or_create_by(
  name: 'Pamplona', 
  code: 'PA', 
  opening_hours: opening_hours, 
  start_at: start_at, 
  end_at: end_at,
  weekdays: weekdays)

Access.find_or_create_by(
  user_id: admin.id,
  office_id: pamplona.id,
  allow: true
)

Access.find_or_create_by(
  user_id: secretary_pamplona_01.id,
  office_id: pamplona.id,
  allow: true
)

Access.find_or_create_by(
  user_id: secretary_pamplona_02.id,
  office_id: pamplona.id,
  allow: true
)

5.times do |i|
  Clinic.find_or_create_by(
    office_id: pamplona.id,
    code: "Sala #{i + 1}",
    color: "#80b1d9"
  )
end

veiga =  Office.find_or_create_by(
  name: 'Veiga Filho', 
  code: 'VF', 
  opening_hours: opening_hours, 
  start_at: start_at, 
  end_at: end_at,
  weekdays: weekdays)


Access.find_or_create_by(
  user_id: admin.id,
  office_id: veiga.id,
  allow: true
)

Access.find_or_create_by(
  user_id: secretary_veiga_01.id,
  office_id: veiga.id,
  allow: true
)

cardeal  = Office.find_or_create_by(
  name: 'Cardeal Arcoverde', 
  code: 'CA', 
  opening_hours: opening_hours, 
  start_at: start_at, 
  end_at: end_at,
  weekdays: weekdays)

  Access.find_or_create_by(
  user_id: admin.id,
  office_id: cardeal.id,
  allow: true
)

Access.find_or_create_by(
  user_id: secretary_cardeal_01.id,
  office_id: cardeal.id,
  allow: true
)

  Access.find_or_create_by(
    user_id: secretary_cardeal_02.id,
    office_id: cardeal.id,
    allow: true
  )

  8.times do |i|
    Clinic.find_or_create_by(
      office_id: cardeal.id,
      code: "Sala #{i + 1}",
      color: "#ebe52f"
    )
  end  

FactoryBot.create(:company, :density)
FactoryBot.create(:company, :pronto)

FactoryBot.create(:holiday, :NewYear)
FactoryBot.create(:holiday, :Carnival)
FactoryBot.create(:holiday, :GoodFriday)
FactoryBot.create(:holiday, :TiradentesDay)
FactoryBot.create(:holiday, :LaborDay)
FactoryBot.create(:holiday, :CorpusChristi)
FactoryBot.create(:holiday, :ConstitutionalistRevolution)
FactoryBot.create(:holiday, :IndependenceOfBrazil)
FactoryBot.create(:holiday, :LadyOfAparecid)
FactoryBot.create(:holiday, :BlackConsciousness)
FactoryBot.create(:holiday, :ProclamationOftheRepublic)
FactoryBot.create(:holiday, :Christmas)

