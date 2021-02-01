# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Doctor, type: :model do
  subject { create(:doctor) }
  it { expect(subject).to be_valid }
end
