# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Doctors', type: :request do
  describe 'GET /doctors' do
    let(:admin) { create(:user, :admin) }
    it 'list all doctors' do
      sign_in(admin)
      get doctors_path
      expect(response).to have_http_status(:success)
    end
  end
end
