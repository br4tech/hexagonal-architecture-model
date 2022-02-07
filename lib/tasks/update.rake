# frozen_string_literal: true

namespace :update do
  desc 'Update amount to attendance'

  task update_amount: :environment do
    contracts = Contract.all
    contracts.each do |contract|
      attendances = contract.attendances
      attendances.each do |attendance|
        attendance.amount = contract.amount unless contract.amount.nil?
        attendance.save
      end
      puts "Contrato #{contract.client.name} atualizado!"
    end
    puts 'Rotina finalizada.'
  end

  task reservation_schedule: :environment do
    clients = Client.all
    clients.each do |client|
      contracts = Contract.where(client_id: client.id)
      contracts.each do |contract|
        reservation = Reservations::ReservationToSchedule.new(contract)
        reservation.reservation_per_attendance
      end
    end
    puts 'Reservas criadas com sucesso!'
  end

  task generate_payroll: :environment do
    clients = Client.all
    clients.each do |client|
      contracts = Contract.where(client_id: client.id)
      reference_date = '01/02/2022'
      contracts.each do |contract|
        bill = Bills::GenerateBills.new(contract, reference_date)
        bill.generate
      end
    end
    puts 'Financeiro gerado com sucesso!'
  end
end
