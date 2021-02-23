json.array! @reservations do |reservation|
  date_format = reservation.all_day_reservation ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'
  json.id reservation.id
  json.title reservation.contract.client.name
  json.start reservation.start_at.strftime(date_format)
  json.end reservation.end_at.strftime(date_format)
  json.backgroundColor reservation.clinic.color
  json.url edit_reservation_path(reservation)
end