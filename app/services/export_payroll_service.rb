# frozen_string_literal: true

class ExportPayrollService
  attr_reader :params

  def initialize(export_params)
  @params = export_params
  end

  def create_remessa   
    pagamentos=[]
    amount = 0;

    @params.each do | item |  
      @payroll = Payroll.find(item)
      
      if @payroll.contract.kind == Contract.contract_types[:type_private]
        amount = @payroll.contract.amount
      else
        if @payroll.contract.category
          amount =  @payroll.payroll_items.sum(:amount) + @payroll.contract.parking_value.to_i
        else
          amount =  @payroll.payroll_items.sum(:amount)
        end       
      end
      
      address = @payroll.contract.contract_combo.client.street + " Nº" + @payroll.contract.contract_combo.client.number.to_s  + " Complemento:" + @payroll.contract.contract_combo.client.complement

      pagamento = Brcobranca::Remessa::Pagamento.new(
        valor: amount,
        data_vencimento: @payroll.due_at,
        nosso_numero: "#{45}#{@payroll.id}#{@payroll.contract.contract_combo.client.id}".to_i,
        codigo_multa: '2',
        percentual_multa: 10.0,
        valor_mora: 0.03,
        documento_sacado: "#{ @payroll.contract.contract_combo.client.document.gsub(".","").gsub("-","").gsub("/","") }",
        nome_sacado: "#{ @payroll.contract.contract_combo.client.name}",
        endereco_sacado: "#{ address }",
        bairro_sacado: "#{ @payroll.contract.contract_combo.client.neighborhood}",
        cep_sacado: "#{ @payroll.contract.contract_combo.client.zipcode.gsub("-","")}",
        cidade_sacado: "#{ @payroll.contract.contract_combo.client.city}",
        uf_sacado: "#{ @payroll.contract.contract_combo.client.state}",
        numero: @payroll.id) 
               
        pagamentos << pagamento
    end
     
    company = Company.find_by_category(@payroll.contract.category)
    
    # criação da instância
    bradesco = Brcobranca::Remessa::Cnab400::Bradesco.new(
      carteira: "#{company.wallet}",
      agencia: "#{company.agency}",
      conta_corrente: "#{company.current_account}",
      digito_conta: "#{company.digit}",
      empresa_mae: "#{company.name}",
      sequencial_remessa:"#{company.shipping_sequence}",
      codigo_empresa: "#{company.company_code}",
      pagamentos: pagamentos)

      company.shipping_sequence += 1
      company.save!

    # criação da remessa
    remessa = bradesco.gera_arquivo  

    return remessa
    
  end

end