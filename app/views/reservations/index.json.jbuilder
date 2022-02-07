json.array! @reservations do |reservation|
  json.id reservation.id
  json.title reservation.attendance.contract.client.name
  json.start reservation.start_at
  json.end reservation.end_at
  json.backgroundColor reservation.clinic.color
  json.url edit_reservation_path(reservation)
end