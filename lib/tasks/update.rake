# frozen_string_literal: true

require 'csv'

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

  task reservation_odd: :environment do
    reservations = Reservation.where(odd: true)

    # reservations =  Reservation.where('date >= ? AND date < ?',
    #                                       '20/11/2020'.to_date,
    #                                       '20/02/2023'.to_date)

    file = "#{Rails.root}/public/reservation_odd.csv"

    headers = %w[reservation_id contract_id amount attendance_id]

    CSV.open(file, 'w', write_headers: true, headers: headers, col_sep: ',') do |write|
      reservations.each do |reservation|
        contract = Contract.find(reservation.contract_id)
        attendance = contract.attendances.last
        write << [reservation.id, contract.id, contract.amount, attendance.id]
      end
    end
    puts 'Arquivo de update gerado com sucesso!'
  end

  task reservation_odd_update: :environment do
    reservations = Reservation.where(odd: true)

    # reservations =  Reservation.where('date >= ? AND date < ?',
    # '20/11/2020'.to_date,
    # '20/02/2023'.to_date)

    CSV.foreach("#{Rails.root}/public/reservation_odd.csv", headers: true) do |csv|
      reservation = Reservation.find(csv['reservation_id'])
      reservation.attendance_id = csv['attendance_id']
      reservation.save
    end
    puts 'Reservas extras atualizadas com sucesso!'
  end

  task generate_payroll: :environment do
    clients = Client.where.not(id: [26,31,479])
    # clients = Client.all
    clients.each do |client| 
      contracts = Contract.where(client_id: client.id)
      reference_date = '01/05/2023'
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
