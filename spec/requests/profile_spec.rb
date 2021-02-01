# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Profile', type: :request do
  describe 'GET /perfil' do
    let(:admin) { create(:user, :admin) }

    it 'current user info' do
      sign_in(admin)
      get profile_path
      expect(response).to have_http_status(:success)
    end
  end
end
