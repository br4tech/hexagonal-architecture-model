# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'offices/index', type: :view do
  before(:each) do
    assign(:offices, [
             Office.create!(
               name: 'Maestro Cardim',
               code: 'PC02',
               address: 'Avenida Paulista',
               phone: '+55 11 42424242'
             ),
             Office.create!(
               name: 'Pamplone',
               code: 'PC03',
               address: 'Rua Pamplona, 145',
               phone: '11 90909090'
             )
           ])
  end

  it 'renders a list of offices' do
    render
    assert_select 'div.card', count: 2
  end
end
