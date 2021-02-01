# encoding: utf-8
class CreateMedicalInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :medical_infos do |t|
      t.references :client, null: false, foreign_key: true
      t.text :health_care                       # Convênios / Planos de Saúde
      t.integer :payment_methods, array: true
      t.boolean :pay_first, default: false      # Deve receber pagamento antes da consulta?     
      t.integer :receipt_type                   # Tipo de Recibo ¯\_(ツ)_/¯
      
    end

    add_index :medical_infos, :payment_methods, using: 'gin'
  end
end
