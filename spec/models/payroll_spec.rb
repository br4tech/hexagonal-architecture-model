require 'rails_helper'

RSpec.describe Payroll, type: :model do
  let(:payroll){ FactoryBot.build(:payroll)}

  # verifica os relacionamentos
  it{ is_expected.to belong_to(:client)}
  it{ is_expected.to have_many(:payroll_items)}

  # verifica os campos obrigatorios a ser preenchidos
  it{ is_expected.to validate_presence_of :emission }
  it{ is_expected.to validate_presence_of :due_at }
  it{ is_expected.to validate_presence_of :amount}

  # verifica se os campos ainda existe no database
  it{ is_expected.to respond_to(:emission)}
  it{ is_expected.to respond_to(:client_id)}
  it{ is_expected.to respond_to(:due_at)}
  it{ is_expected.to respond_to(:ends_at)}
  it{ is_expected.to respond_to(:amount)}

end
