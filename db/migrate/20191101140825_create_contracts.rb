class CreateContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :contracts do |t|   
      t.references :client, null: false, foreign_key: true   
      t.datetime :starts_at           # Data de In�cio do Contrato
      t.datetime :ends_at             # Data de T�rmino do Contrato
      t.decimal :amount, precision: 8, scale: 2 # Valor do Contrato
      t.integer :revenues_at          # Dia de Faturamento
      t.integer :due_at               # Dia de Vencimento
      t.decimal :forfeit, precision: 8, scale: 2 # Multa por Cancelamento
      t.integer :kind                 # Modelo de Contrato
      t.integer :frequency            # Periodicidade     
      t.integer :rescheduling_allowed # No. de Reagendamentos Permitidos
      t.boolean :parking, default: false # Utiliza Estacionamento?
      t.string :car_license_plate     # Placa do Ve�culo
      t.integer :category,  default: 0
      t.timestamps
    end
  end
end
