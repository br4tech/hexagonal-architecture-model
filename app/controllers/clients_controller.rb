# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :set_client, only: %i[combo contract contracts info]

  def contracts
    @contracts = @client.contract_combos
  end

  def combo
    @kind = PersonKind.all
    @combo = @client.contract_combos.find(params[:combo_id])
    @contract = @combo.contracts.find_or_initialize_by(category: Company.categories[params[:category]])

    if @contract.new_record?
      @contract.client = @client.presence || Client.new
      @contract.discounts.build
      attendances = @combo.contracts.first.attendances
      if attendances.present?
        attendances.each do |att|
          attendance = Attendance.new
          attendance.clinic_id = att.clinic_id
          attendance.office_id = att.office_id
          attendance.weekdays = att.weekdays
          attendance.starts_at = att.starts_at
          attendance.ends_at = att.ends_at
          attendance.frequency = att.frequency
          attendance.is_recurrent = att.is_recurrent
          attendance.time_starts = att.time_starts
          attendance.time_ends = att.time_ends

          @contract.attendances << attendance
        end
        @contract.client_id = @combo.contracts.first.client_id
      else
        @contract.attendances.build
      end
    end
  end

  def search
    @clients = Client.where('LOWER(name) LIKE ?', "%#{params[:query].downcase}%").order(:name)
    render json: @clients.as_json(only: %i[id name email document zipcode street number neighborhood city state], methods: [:value])
  end

  def info
    @combo = @client.contract_combos.find(params[:combo_id])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_client
    @client = Client.find(params[:id])
  end
end
