# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Offices', type: :request do
  describe 'GET /offices' do
    let(:admin) { create(:user, :admin) }
    it 'list all offices' do
      sign_in(admin)
      get offices_path
      expect(response).to have_http_status(:success)
    end
  end
end
