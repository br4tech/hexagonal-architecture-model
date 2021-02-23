# frozen_string_literal: true

json.extract! doctor, :id, :name, :document, :email, :phone, :expertises, :gender
json.url doctor_url(doctor, format: :json)
