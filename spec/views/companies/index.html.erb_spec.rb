require 'rails_helper'

RSpec.describe "companies/index", type: :view do
  before(:each) do
    assign(:companies, [
      Company.create!(
        name: "",
        document: "Document",
        wallet: 2,
        agency: 3,
        current_account: 4,
        digit: 5,
        company_code: "Company Code",
        shipping_sequence: 6
      ),
      Company.create!(
        name: "",
        document: "Document",
        wallet: 2,
        agency: 3,
        current_account: 4,
        digit: 5,
        company_code: "Company Code",
        shipping_sequence: 6
      )
    ])
  end

  it "renders a list of companies" do
    render
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: "Document".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: 4.to_s, count: 2
    assert_select "tr>td", text: 5.to_s, count: 2
    assert_select "tr>td", text: "Company Code".to_s, count: 2
    assert_select "tr>td", text: 6.to_s, count: 2
  end
end
