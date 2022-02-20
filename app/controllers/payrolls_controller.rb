# frozen_string_literal: true

class PayrollsController < ApplicationController
  def index
    @contracts =  ContractCombo.includes(:client).order('clients.name') 
    @payrolls = Payroll.all
  end

  def show; end

  def export_payroll
    @export = ExportPayrollService.new(params[:payrolls])
    remessa = @export.create_remessa

    send_data remessa, :content_type => 'text/plain', :filename => "remessa.rst" , :disposition => "attachment"
  end

  def reprocess_payroll
    ReprocessPayrollWorker.new.perform(session[:month_selected].to_i + 1)
  end

  def export_to_exel
    reference_date =  DateTime.now + 1.month
    @bills = Bills::ReportBills.new(reference_date).generate
    
    respond_to do |format|
      format.xlsx
    end
  end

  private

  def export_params
    params.require(:export).permit(payrolls: {})
  end
end
