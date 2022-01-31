# frozen_string_literal: true

class PayrollsController < ApplicationController
  def index
    @contracts =  ContractCombo.includes(:client).order('clients.name') 
    @payrolls = Payroll.page(params[:page]).per(50)
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

  private

  def export_params
    params.require(:export).permit(payrolls: {})
  end
end
