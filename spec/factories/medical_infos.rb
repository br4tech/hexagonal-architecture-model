# frozen_string_literal: true

FactoryBot.define do
  factory :medical_info do
    doctor
    health_care { 'Unimed, Bradesco Saúde' } # Convênios / Planos de Saúde
    payment_methods { [0, 3] }
    pay_first { false }       # Deve receber pagamento antes da consulta?   
    receipt_type { 0 }        # Tipo de Recibo ¯\_(ツ)_/¯
  end
end
