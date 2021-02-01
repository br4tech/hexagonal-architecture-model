json.array! @days_off do |dayoff|
  json.name dayoff.description
  json.start dayoff.date
  json.color dayoff.color
end