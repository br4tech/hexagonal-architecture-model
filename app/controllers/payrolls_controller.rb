# frozen_string_literal: true

# Controller payrolls
class PayrollsController < ApplicationController

  before_action :load_bills

  def index
    @contracts = ContractCombo.includes(:client).order('clients.name')
  end

  def show; end

  def export_payroll
    shipping = Bills::Bank::ShippingFile.new(params[:payrolls], 1)
    remessa = shipping.generate_shipping 
    
    send_data remessa, content_type: 'text/plain', filename: 'remessa.rst', disposition: 'attachment'
  end

  def reprocess_payroll
    ReprocessPayrollWorker.new.perform(session[:month_selected].to_i + 1)
  end

  def export_to_exel
    reference_date = DateTime.now + 1.month
    @bills = Bills::ReportBills.new(reference_date).generate

    respond_to do |format|
      format.xlsx
    end
  end

  private

  def load_bills
    reference_date = DateTime.now + 1.month
    @payrolls = Bills::ReportBills.new(reference_date).generate
  end

  def export_params
    params.require(:export).permit(payrolls: {})
  end
end
