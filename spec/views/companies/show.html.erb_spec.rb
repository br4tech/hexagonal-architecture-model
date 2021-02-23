require 'rails_helper'

RSpec.describe "companies/show", type: :view do
  before(:each) do
    @company = assign(:company, Company.create!(
      name: "",
      document: "Document",
      wallet: 2,
      agency: 3,
      current_account: 4,
      digit: 5,
      company_code: "Company Code",
      shipping_sequence: 6
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Document/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/Company Code/)
    expect(rendered).to match(/6/)
  end
end
