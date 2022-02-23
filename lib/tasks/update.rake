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

  task day_off: :environment do
    DayOff.destroy_all

    Holiday.all.each do |holiday|
      start_at = holiday.starts_at.to_date
      end_at = holiday.ends_at.to_date

      day_offs = (start_at..end_at).to_a

      day_offs.each do |day_off|
        DayOff.find_or_create_by(
          date: day_off,
          holiday_id: holiday.id,
          color: holiday.color,
          description: holiday.name
        )
      end
    end

    puts 'Feriado(s) gerado com sucesso!'
  end

  task reservation_schedule: :environment do
    clients = Client.where.not(id: [44,82,89,412,776,235,640,70,872,639,851,894,840])
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
    clients = Client.where.not(id: [44,82,89,412,776,235,640,70,872,639,851,894,840])
    clients.each do |client|
      contracts = Contract.where(client_id: client.id)
      reference_date = '01/02/2022'
      contracts.each do |contract|
       unless contract.category.zero?
          bill = Bills::GenerateBills.new(contract, reference_date)
          bill.generate
        end
      end
    end
    puts 'Financeiro gerado com sucesso!'
  end
end
