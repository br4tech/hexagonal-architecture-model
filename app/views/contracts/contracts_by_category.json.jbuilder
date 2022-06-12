# frozen_string_literal: true

json.array! @contracts_by_category do |contract|
  json.id contract.id
  json.name contract.client.name
end
