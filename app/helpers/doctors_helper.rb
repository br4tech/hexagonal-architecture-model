# frozen_string_literal: true

# Doctor Presenters and Helper
module DoctorsHelper
  def formal_doctor_name(doctor)
    return nil if doctor.nil?
    first_name = doctor.name.split.first
    last_name = doctor.name.split.last   
  end

  def prefix(gender)
    gender == 'male' ? 'Dr. ' : 'Dra. '
  end
end
