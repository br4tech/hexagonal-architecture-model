# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }
  it { expect(subject).to be_valid }

  describe '#admin?' do
    let(:admin) { create(:user, :admin) }
    let(:manager) { create(:user, :manager) }

    context 'when regular role' do
      it { expect(subject).to_not be_admin }
    end

    context 'when manager' do
      it { expect(manager).to_not be_admin }
    end

    context 'when admin' do
      it { expect(admin).to be_admin }
    end
  end
end
