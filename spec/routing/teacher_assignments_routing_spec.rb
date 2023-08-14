# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TeacherAssignmentsController do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/teacher_assignments').to route_to('teacher_assignments#index')
    end

    it 'routes to #new' do
      expect(get: '/teacher_assignments/new').to route_to('teacher_assignments#new')
    end

    it 'routes to #show' do
      expect(get: '/teacher_assignments/1').to route_to('teacher_assignments#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/teacher_assignments/1/edit').to route_to('teacher_assignments#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/teacher_assignments').to route_to('teacher_assignments#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/teacher_assignments/1').to route_to('teacher_assignments#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/teacher_assignments/1').to route_to('teacher_assignments#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/teacher_assignments/1').to route_to('teacher_assignments#destroy', id: '1')
    end
  end
end
