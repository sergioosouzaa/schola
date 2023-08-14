# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EnrollmentsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/enrollments').to route_to('enrollments#index')
    end

    it 'routes to #new' do
      expect(get: '/enrollments/new').to route_to('enrollments#new')
    end

    it 'routes to #show' do
      expect(get: '/enrollments/XPTO123').to route_to('enrollments#show', code: 'XPTO123')
    end

    it 'routes to #edit' do
      expect(get: '/enrollments/XPTO123/edit').to route_to('enrollments#edit', code: 'XPTO123')
    end

    it 'routes to #create' do
      expect(post: '/enrollments').to route_to('enrollments#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/enrollments/XPTO123').to route_to('enrollments#update', code: 'XPTO123')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/enrollments/XPTO123').to route_to('enrollments#update', code: 'XPTO123')
    end

    it 'routes to #destroy' do
      expect(delete: '/enrollments/XPTO123').to route_to('enrollments#destroy', code: 'XPTO123')
    end
  end
end
