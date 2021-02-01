# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Expertise, type: :model do
  subject { create(:expertise, name: 'Odontologia') }
  it { expect(subject).to be_valid }

  describe 'validations' do
    let(:empty_expertise) { build(:expertise, name: '') }
    let(:duplicated_expertise) { create(:expertise, name: 'Odontologia') }

    it('name is mandatory') { expect(empty_expertise).to be_invalid }
    xit('is unique') { expect(duplicated_expertise).to be_invalid }
  end
end
