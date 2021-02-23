require 'rails_helper'

RSpec.describe Contract, type: :model do
  subject { create(:contract) }
  it { expect(subject).to be_valid } 
end
