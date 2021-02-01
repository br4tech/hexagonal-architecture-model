# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'offices/new', type: :view do
  before(:each) do
    assign(:office, Office.new(
                      name: Faker::Name.name,
                      code: 'PC009',
                      address: 'Time Square',
                      phone: '+1 555 555'
                    ))
  end

  it 'renders new office form' do
    render

    assert_select 'form[action=?][method=?]', offices_path, 'post' do
      assert_select 'input[name=?]', 'office[name]'
      assert_select 'input[name=?]', 'office[code]'
      assert_select 'input[name=?]', 'office[address]'
      assert_select 'input[name=?]', 'office[phone]'
    end
  end
end
