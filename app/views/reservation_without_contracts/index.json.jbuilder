json.array! @reservations_without_contract do |reservation|
  date_format = reservation.all_day_reservation ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'
  json.id reservation.id
  json.title reservation.client.name
  json.start reservation.start_at.strftime(date_format)
  json.end reservation.end_at.strftime(date_format)
  json.borderColor reservation.clinic.color
  json.url edit_reservation_without_contract_path(reservation)
end