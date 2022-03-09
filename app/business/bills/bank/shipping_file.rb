# frozen_string_literal: true

module Bills
  module Bank
    # Generate shipping file
    class ShippingFile
      attr_reader :bills, :category

      def initialize(bills, category)
        @bills = bills
        @category = category
      end

      def generate_shipping
        return nil if bills.empty?

        company = Company.find_by(category: category)
        shipping = bank_shipping(company)
        company.shipping_sequence += 1
        company.save!

        shipping
      end

      def all_bills
        Payroll.find(bills)
      end

      def bank_shipping(company)
        @bank = Brcobranca::Remessa::Cnab400::Bradesco.new
        @bank.empresa_mae = company.name
        banck_account(company)

        all_bills.each do |bill|
          @bank.pagamentos << payments(bill)
        end

        @banck
      end

      def banck_account(company)
        @bank.carteira = company.wallet
        @bank.agencia = company.agency
        @bank.conta_corrente = company.current_account
        @bank.digito_conta = company.digit
      end

      def payments(bill)
        @payments = []
        @payment = Brcobranca::Remessa::Pagamento.new
        @payment.numero = bill.id
        @payment.data_vencimento = bill.due_at
        @payment.valor = payments_amount(bill)
        @payment.nosso_numero = "45#{bill.id} + #{bill.contract.id}".to_i
        payment_defaults
        client_shipping(bill.contract.client)
        
        binding.pry
        
        @payments << @payment
      end

      def client_shipping(client)
        @payment.nome_sacado = client.name
        @payment.bairro_sacado = client.neighborhood
        @payment.cep_sacado =  client.zipcode.gsub('-', '')
        @payment.endereco_sacado = "#{client.street} + Nº #{client.number} + Complemento: #{client.complement}"
        @payment.cidade_sacado = client.city
        @payment.uf_sacado = client.state
      end

      def payment_defaults
        @payment.codigo_multa = '2'
        @payment.percentual_multa = 10.0
        @payment.valor_mora = 0.03
      end
      
      def payments_amount(bill)    
        if bill.contract.kind.zero?
          bill.payroll_items.inject(0) { |sum, item| sum + item[:amount] }.to_f
        else
          bill.contract.amount.to_f
        end
      end
    end
  end
end
