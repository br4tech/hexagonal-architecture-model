# frozen_string_literal: true

class ContractService
  # ContractService handle with Contract particulars
  attr_reader :params
  attr_accessor :contract

  PERMITTED_PARAMS = %i[contract_combo_id category starts_at ends_at amount revenues_at due_at forfeit kind rescheduling_allowed parking parking_value car_license_plate].freeze

  def initialize(contract_params, contract_id = nil)
    @params = contract_params
    @contract_id = contract_id
  end

  def create
    Contract.transaction do
      build
      commit
    end
  end

  def update
    Contract.transaction do
      rebuild
      commit
    end
  end

  private

  def prepare
    params[:forfeit] = params[:forfeit].gsub(/[^0-9.]/, '').try(:to_f)
    params[:amount] = params[:amount].gsub(/[^0-9.]/, '').try(:to_f)
  end

  # Build Contract
  def build
    @contract = Contract.new(params)
  end

  def rebuild
    @contract = Contract.find(@contract_id)
    @contract.assign_attributes(@params)
  end

  def commit
    if @contract.valid?
      @contract.save
      @contract.contract_combo_id = @contract.client.contract_combos.create.id if params[:contract_combo_id].blank?
      @contract.save
    else
      @contract.errors.full_messages
    end
  end
end
