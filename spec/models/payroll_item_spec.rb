require 'rails_helper'

RSpec.describe PayrollItem, type: :model do
  let(:payroll_item){ FacotyBot.build(:payroll_item)}

  # verifica os relacionamentos
  it{ is_expected.to belong_to(:office)}
  it{ is_expected.to belong_to(:payroll)}

  # verifica os campos obrigatorios a ser preenchidos
  it{ is_expected.to validate_presence_of :hours }
  it{ is_expected.to validate_presence_of :amount }
  it{ is_expected.to validate_presence_of :period }

  # verifica se os campos ainda existe no database
  it{ is_expected.to respond_to(:hours)}
  it{ is_expected.to respond_to(:amount)}
  it{ is_expected.to respond_to(:period)}
  it{ is_expected.to respond_to(:office_id)}
  it{ is_expected.to respond_to(:payroll_id)}
end
