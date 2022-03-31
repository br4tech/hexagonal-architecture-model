# frozen_string_literal: true

class PayrollWorker
  include Sidekiq::Worker

  def perform
    clients = Client.all
    clients.each do |client|
      contracts = Contract.where(client_id: client.id)
      reference_date = '01/02/2022'
      contracts.each do |contract|
        bill = Bills::GenerateBills.new(contract, reference_date)
        bill.generate
      end
    end
  end
end
