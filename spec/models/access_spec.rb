# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Access, type: :model do
  subject { create(:access) }
  it { expect(subject).to be_valid }
end
