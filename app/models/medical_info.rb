# frozen_string_literal: true

# Doctor extra data to represents medical settings
class MedicalInfo < ApplicationRecord
  # Fields
  # doctor          : String : Doctor Association
  # health_care     : String : Convênios / Planos de Saúde
  # payment_methods : Array : Métodos de Pagamento
  # pay_first       : Boolean : Deve receber pagamento antes da consulta?
  # use_pay_point   : Boolean : Utiliza maquininha de pagamento?
  # receipt_type    : Integer : Tipo de Recibo
  enum payment_options: { cash: 0, debit: 1, credit: 2, transfer: 3 }
  enum receipt_type: { cpf: 0, cnpj: 1, nf: 2 }

  belongs_to :doctor
end
