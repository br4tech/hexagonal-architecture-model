require 'rails_helper'

RSpec.describe "Payrolls", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/payroll/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/payroll/show"
      expect(response).to have_http_status(:success)
    end
  end

end
