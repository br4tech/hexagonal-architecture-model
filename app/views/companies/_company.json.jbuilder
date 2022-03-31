# frozen_string_literal: true

json.extract! company, :id, :name, :document, :wallet, :agency, :current_account, :digit, :company_code, :shipping_sequence, :created_at, :updated_at
json.url company_url(company, format: :json)
