# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Office, type: :model do
  subject { create(:office) }
  it { expect(subject).to be_valid }
end
