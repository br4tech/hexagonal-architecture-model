require 'rails_helper'

RSpec.describe ClientDoctor, type: :model do
  let(:client_doctor){ FactoryBot.build(:client_doctor)}

  it{ is_expected.to belong_to(:doctor)}
  it{ is_expected.to belong_to(:client)}

  it{ is_expected.to respond_to(:doctor_id)}
  it{ is_expected.to respond_to(:client_id)}

end
