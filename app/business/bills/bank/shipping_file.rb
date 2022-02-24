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
          @bank.pagamentos << bank_payments(bill)
        end

        @banck
      end

      def banck_account(company)
        @bank.carteira = company.wallet
        @bank.agencia = company.agency
        @banck.conta_corrente = company.current_account
        @bank.digito_conta = company.digi
      end

      def payments(bill)
        @payments = Brcobranca::Remessa::Pagamento.new
        @payments.numero = bill.id
        @payments.data_vencimento = bill.due_at
        @payments.valor = bill.sum_amount
        @payments.nosso_numero = "45#{bill.id} + #{bill.contract.id}".to_i
        payment_defaults
        client_shipping(bill.contract.client)

        @payments
      end

      def client_shipping(client)
        @payments.nome_sacado = client.name
        @payments.bairro_sacado = client.neighborhood
        @payments.cep_sacado =  client.zipcode.gsub('-', '')
        @payments.endereco_sacado = "#{client.street} + Nº #{client.number} + Complemento: #{client.complement}"
        @payments.cidade_sacado = client.city
        @payments.uf_sacado = client.state
      end

      def payment_defaults
        @payments.codigo_multa = '2'
        @payments.percentual_multa = 10.0
        @payments.valor_mora = 0.03
      end
    end
  end
end
