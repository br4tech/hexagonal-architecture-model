# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DoctorsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/clientes').to route_to('doctors#index')
    end

    it 'routes to #new' do
      expect(get: '/clientes/cadastro').to route_to('doctors#new')
    end

    it 'routes to #show' do
      expect(get: '/clientes/1').to route_to('doctors#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/clientes/1/edicao').to route_to('doctors#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/clientes').to route_to('doctors#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/clientes/1').to route_to('doctors#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/clientes/1').to route_to('doctors#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/clientes/1').to route_to('doctors#destroy', id: '1')
    end
  end
end
