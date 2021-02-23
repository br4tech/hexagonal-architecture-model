# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'offices/edit', type: :view do
  before(:each) do
    @office = assign(:office, Office.create!(
                                name: Faker::Name.name,
                                code: 'OTNORP',
                                address: 'Backer Street, 221B',
                                phone: '+55 11 8989898989'
                              ))
  end

  it 'renders the edit office form' do
    render

    assert_select 'form[action=?][method=?]', office_path(@office), 'post' do
      assert_select 'input[name=?]', 'office[name]'
      assert_select 'input[name=?]', 'office[code]'
      assert_select 'input[name=?]', 'office[address]'
      assert_select 'input[name=?]', 'office[phone]'
    end
  end
end
