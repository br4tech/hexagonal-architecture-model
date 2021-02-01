# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OfficesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/unidades').to route_to('offices#index')
    end

    it 'routes to #show' do
      expect(get: '/unidades/1').to route_to('offices#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/unidades/1/edicao').to route_to('offices#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/unidades').to route_to('offices#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/unidades/1').to route_to('offices#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/unidades/1').to route_to('offices#update', id: '1')
    end
  end
end
