require 'rails_helper'

RSpec.describe "ReservationsWithoutContracts", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/reservations_without_contract/index"
      expect(response).to have_http_status(:success)
    end
  end

end
