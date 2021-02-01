require 'rails_helper'

RSpec.describe "companies/edit", type: :view do
  before(:each) do
    @company = assign(:company, Company.create!(
      name: "",
      document: "MyString",
      wallet: 1,
      agency: 1,
      current_account: 1,
      digit: 1,
      company_code: "MyString",
      shipping_sequence: 1
    ))
  end

  it "renders the edit company form" do
    render

    assert_select "form[action=?][method=?]", company_path(@company), "post" do

      assert_select "input[name=?]", "company[name]"

      assert_select "input[name=?]", "company[document]"

      assert_select "input[name=?]", "company[wallet]"

      assert_select "input[name=?]", "company[agency]"

      assert_select "input[name=?]", "company[current_account]"

      assert_select "input[name=?]", "company[digit]"

      assert_select "input[name=?]", "company[company_code]"

      assert_select "input[name=?]", "company[shipping_sequence]"
    end
  end
end
