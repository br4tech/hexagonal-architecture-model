# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MedicalInfo, type: :model do
  subject { create(:medical_info) }
  it { expect(subject).to be_valid }
end
