# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Clinic, type: :model do
  subject { create(:clinic) }
  it { expect(subject).to be_valid }
end
