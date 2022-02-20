# frozen_string_literal: true

module Bills
  # Report bills to process
  class ReportBills
    attr_reader :reference_date

    def initialize(reference_date)
      @reference_date = reference_date
      @plan = []
    end

    def generate
      master_plan.each do |bill|
        hash = {}
        hash[:id] = bill.id
        hash[:client] = bill.contract.client.name
        hash[:kind] = contract_type(bill.contract.category)
        hash[:items] = sub_plan(bill.id)
        @plan << hash
      end
      @plan
    end

    def master_plan
      Payroll.where(due_at: date_cut_start.to_date..date_cut_end.to_date)
    end

    def sub_plan(payroll_id)
      items = PayrollItem.where(payroll_id: payroll_id)
      hash_items(items)
    end

    def contract_type(category)
      category.zero? ? 'pronto' : 'density'
    end

    def hash_items(items)
      @sub_plan = []
      items.each do |item|
        hash = {}
        hash[:id] = item.id
        hash[:office] = item.clinic.office.name
        hash[:clinic] = item.clinic.code
        hash[:amount] = item.amount
        hash[:hours] = item.hours
        @sub_plan << hash
      end
      @sub_plan
    end

    def date_cut_start
      "#{first_day_of_the_month}/#{reference_month}/#{reference_year}".to_date
    end

    def date_cut_end
      "#{last_day_of_the_month}/#{reference_month}/#{reference_year}".to_date
    end

    def first_day_of_the_month
      reference_date.to_date.beginning_of_month
    end

    def last_day_of_the_month
      reference_date.to_date.end_of_month
    end

    def reference_month
      reference_date.to_date.month
    end

    def reference_year
      reference_date.to_date.year
    end
  end
end
