# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MainController, type: :controller do
  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to_not have_http_status(:error)
    end
  end
end
