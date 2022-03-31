# frozen_string_literal: true

class ExportPayrollService
  attr_reader :params

  def initialize(export_params)
    @params = export_params
  end

  def create_remessa
    pagamentos = []
    amount = 0

    @params.each do |item|
      @payroll = Payroll.find(item)

      amount = if @payroll.contract.kind == Contract.contract_types[:type_private]
                 @payroll.contract.amount
               elsif @payroll.contract.category
                 @payroll.payroll_items.sum(:amount) + @payroll.contract.parking_value.to_i
               else
                 @payroll.payroll_items.sum(:amount)
               end

      address = "#{@payroll.contract.contract_combo.client.street} Nº#{@payroll.contract.contract_combo.client.number} Complemento:#{@payroll.contract.contract_combo.client.complement}"

      pagamento = Brcobranca::Remessa::Pagamento.new(
        valor: amount,
        data_vencimento: @payroll.due_at,
        nosso_numero: "45#{@payroll.id}#{@payroll.contract.contract_combo.client.id}".to_i,
        codigo_multa: '2',
        percentual_multa: 10.0,
        valor_mora: 0.03,
        documento_sacado: @payroll.contract.contract_combo.client.document.gsub('.', '').gsub('-', '').gsub('/', '').to_s,
        nome_sacado: @payroll.contract.contract_combo.client.name.to_s,
        endereco_sacado: address.to_s,
        bairro_sacado: @payroll.contract.contract_combo.client.neighborhood.to_s,
        cep_sacado: @payroll.contract.contract_combo.client.zipcode.gsub('-', '').to_s,
        cidade_sacado: @payroll.contract.contract_combo.client.city.to_s,
        uf_sacado: @payroll.contract.contract_combo.client.state.to_s,
        numero: @payroll.id
      )

      pagamentos << pagamento
    end

    company = Company.find_by(category: @payroll.contract.category)

    # criação da instância
    bradesco = Brcobranca::Remessa::Cnab400::Bradesco.new(
      carteira: company.wallet.to_s,
      agencia: company.agency.to_s,
      conta_corrente: company.current_account.to_s,
      digito_conta: company.digit.to_s,
      empresa_mae: company.name.to_s,
      sequencial_remessa: company.shipping_sequence.to_s,
      codigo_empresa: company.company_code.to_s,
      pagamentos: pagamentos
    )

    company.shipping_sequence += 1
    company.save!

    # criação da remessa
    bradesco.gera_arquivo
  end
end
