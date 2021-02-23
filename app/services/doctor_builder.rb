# frozen_string_literal: true

class DoctorBuilder
  # DoctorBuilder handle with Doctor particulars
  attr_reader :params
  attr_accessor :doctor

  ATTRS = %i(name document email phone address crm)

  def initialize(params)
    @params = doctor_params(params)
    first_or_build
    @doctor
  end

  private

  def first_or_build
    params[:id].present? ? update : build
  end

  def update
    @doctor = Doctor.find(params[:id])
    @doctor.assign_attributes(@params)
    @doctor.save
  end

  def build
    begin
      params[:document] = @params[:document].gsub(/\D+/, '')    
      @doctor = Doctor.find_or_initialize_by(document: params[:document])
      @doctor.assign_attributes(@params)
      @doctor.save     
    rescue   
      raise @doctor.errors.full_messages.join(', ')
    end
  end

   def doctor_params(params)
    params.require(:doctor)
      .permit(:id, :name, :kind_people, :document, :crm, :phone, :email, :gender, :zipcode, :address, :number, :complement, :neighborhood, :city, :state, 
              expertises_attributes: [:id, :name, :duration, :price, :returns, :confirm, :days_to_return, :observations], 
              medical_info_attributes: [:id, :receipt_type, :pay_first, payment_methods: []])
  end

end