# frozen_string_literal: true

json.extract! office, :id, :name, :code, :address, :phone
json.clinics office.clinics, :id, :code
json.url office_url(office, format: :json)
