# frozen_string_literal: true

class PayrollsController < ApplicationController
  def index
    months = %w[Janeiro Fevereiro Marco Abril Maio Junho Julho Agosto Setembro Outubro Novembro Dezembro]

    today = Time.now
    session[:month_selected] = (today.month - 1) % 12

    @month = months.select.with_index { |e, i| e if i == session[:month_selected] }
                   .shift + " #{today.year}"

    s = Payroll.includes(payroll_items: { clinic: :office }, contract: { contract_combo: :client })
               .where(
                  'extract(month from due_at) = ? AND extract(year from due_at) = ?',
                  session[:month_selected].to_i + 1, today.year
                )

    session[:year_selected] = Time.now if session[:year_selected].nil?
    @selected_year = session[:year_selected].to_date.year

    company_category = Company.categories[:pronto]
    @payrolls = s.select { |payroll| payroll.contract.category == company_category }
  end

  def show; end

  def payroll_month
    session[:year_selected] = Time.now
    @selected_year = session[:year_selected].to_date.year

    months = %w[Janeiro Fevereiro Marco Abril Maio Junho Julho Agosto Setembro Outubro Novembro Dezembro]

    if params[:type] == "prev"
      session[:month_selected]= (session[:month_selected] - 1) % 12

      if session[:month_selected] == 0
        session[:year_selected]  = Time.now
      end
    elsif params[:type] == "next"
      session[:month_selected] = (session[:month_selected] + 1) % 12
      if session[:month_selected] == 0
        session[:year_selected]  = Time.now + 1.year
      end
    else
      session[:month_selected]
    end

    @month = months.select.with_index { |e, i| e if i == session[:month_selected] }
                   .shift + " #{session[:year_selected].year}"

    payrolls = Payroll.includes(payroll_items: { clinic: :office }, contract: { contract_combo: :client })
                      .where(
                        'extract(month from due_at) = ? AND extract(year from due_at) = ?',
                        session[:month_selected].to_i + 1, session[:year_selected].year
                      )

    category = params[:tipo].nil? ? Company.categories[:pronto] : Company.categories[params[:tipo]]

    @payrolls = payrolls.select { |payroll| payroll.contract.category == category }
    payroll_category

    respond_to do |format|
      format.js
    end
  end

  def payroll_category  
    @selected_year = session[:year_selected].to_date.year

    today = if session[:month_selected] == 0
              Time.now + 1.year
            else
              Time.now
            end

    payrolls = Payroll.includes(payroll_items: { clinic: :office }, contract: { contract_combo: :client })
                      .where(
                        'extract(month from due_at) = ? AND extract(year from due_at) = ?',
                        session[:month_selected].to_i + 1, today.year
                      )

    category = params[:tipo].nil? ? Company.categories[:pronto] : Company.categories[params[:tipo]]

    @payrolls = payrolls.select { |payroll| payroll.contract.category == category }

    respond_to do |format|
      format.js
    end
  end

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
