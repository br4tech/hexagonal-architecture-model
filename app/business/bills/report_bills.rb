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
        hash[:document] = bill.contract.client.document
        hash[:kind] = contract_type(bill.contract.category)
        hash[:due_at] = bill.due_at
        hash[:items] = sub_plan(bill)
        hash[:sum_amount] = contract_type_private(bill)
        @plan << hash
      end
      @plan
    end

    def master_plan
      Payroll.where(due_at: date_cut_start.to_date..date_cut_end.to_date)
    end

    def sub_plan(bill)
      items = PayrollItem.where(payroll_id: bill.id)
      hash_items(items) + hash_parking(bill.contract)
    end

    def contract_type(category)
      category.zero? ? 'pronto' : 'density'
    end

    def contract_type_private(bill)
      items = sub_plan(bill)
      if bill.contract.kind.zero?
        items.inject(0) { |sum, item| sum + item[:amount] }.to_f
      else
        bill.contract.amount.to_f
      end
    end

    def hash_items(items)
      @sub_plan = []
      items.each do |item|
        hash = {}
        hash[:id] = item.id
        hash[:period] = item.period
        hash[:office] = item.clinic.office.name
        hash[:clinic] = item.clinic.code
        hash[:amount] = item.amount
        hash[:odd] = item.odd? ? 'Avulso' : 'Contrato'
        hash[:hours] = item.hours
        @sub_plan << hash
      end
      @sub_plan
    end

    def hash_parking(contract)
      @sub_plan = []
      if contract.parking?
        hash = {}
        hash[:id] = 'xxx-xxx-xxx'
        hash[:period] = 'xx-xx-xxxx'
        hash[:office] = 'xxxxxxxxxx'
        hash[:clinic] = 'xxxxxxxxxx'
        hash[:amount] = contract.parking_value
        hash[:odd] = 'Estacionamento'
        hash[:hours] = 'xx'
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
      reference_date.to_date.beginning_of_month.day
    end

    def last_day_of_the_month
      reference_date.to_date.end_of_month.day
    end

    def reference_month
      reference_date.to_date.month
    end

    def reference_year
      reference_date.to_date.year
    end
  end
end
