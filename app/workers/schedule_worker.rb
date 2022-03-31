# frozen_string_literal: true

class ScheduleWorker
  include Sidekiq::Worker

  def perform(contract_id)
    contract = Contract.find(contract_id)

    contract.attendances.each do |attendance|
      next unless attendance.starts_at.present? && attendance.ends_at.present?

      case attendance.frequency
      when 0
        first = attendance.starts_at.to_date
        last =  attendance.ends_at.to_date
        reservations = (first..last).to_a.select { |k| attendance.weekdays.include?(k.wday) }.reject(&:blank?)
        # reservations = reservations.select{ |current| current.year == Date.today.year}
        reservations.each do |reserve|
          next unless reserve >= first

          start_at = "#{reserve} #{attendance.time_starts}".to_datetime.strftime('%Y-%m-%dT%H:%M:%S')
          end_at = "#{reserve} #{attendance.time_ends}".to_datetime.strftime('%Y-%m-%dT%H:%M:%S')

          next if DayOff.where(date: reserve).count.positive?

          Reservation.find_or_create_by(contract_id: contract.id,
                                        date: reserve.to_date,
                                        office_id: attendance.office_id,
                                        clinic_id: attendance.clinic_id,
                                        category: contract.category,
                                        start_at: start_at,
                                        end_at: end_at)

          reservation_room(attendance.clinic_id, start_at, end_at)
        end
      when 1
        first = attendance.starts_at.to_date.beginning_of_week
        last =  attendance.ends_at.to_date

        group = (first..last).to_a.in_groups_of(7)
        group = group.map { |k| k.select { |j| j if !j.nil? && j >= attendance.starts_at } }

        group = group.map { |k| k.select { |j| attendance.weekdays.include?(j.wday) } }

        group = group.map { |k| k unless k.empty? }.reject(&:blank?)
        group = group.each_with_index.map { |k, i| k if i.even? }.reject(&:blank?)

        reservations = []
        group.map { |k| k.select { |j| reservations << j if !j.nil? && j >= attendance.starts_at } }
        selected_days = reservations.select { |u| attendance.weekdays.include?(u.wday) }

        selected_days.each do |reserve|
          start_at = "#{reserve} #{attendance.time_starts}".to_datetime.strftime('%Y-%m-%dT%H:%M:%S')
          end_at = "#{reserve} #{attendance.time_ends}".to_datetime.strftime('%Y-%m-%dT%H:%M:%S')

          Reservation.find_or_create_by(contract_id: contract.id,
                                        date: reserve.to_date,
                                        office_id: attendance.office_id,
                                        clinic_id: attendance.clinic_id,
                                        category: contract.category,
                                        start_at: start_at,
                                        end_at: end_at)

          reservation_room(attendance.clinic_id, start_at, end_at)
        end
      end
    end

    r = Reservation.where(category: nil)
    r.each do |r|
      r.category = 0
      r.save
    end

    Rails.logger.debug 'Reserva(s) gerada com sucesso!'
  end

  def reservation_room(clinic_id, start_at, end_at)
    reservations = ReservationAvailable.where(clinic_id: clinic_id, start_at: start_at..end_at, available: true)
    reservations.each do |reservation|
      reservation.available = false
      reservation.save
    end
  end
end
