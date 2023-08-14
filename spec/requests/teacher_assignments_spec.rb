# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/teacher_assignments' do
  let(:subject_model) { create(:subject) }
  let(:teacher) { create(:teacher) }
  let(:course) { create(:course) }
  let(:valid_attributes) do
    attributes_for(
      :teacher_assignment,
      subject_id: subject_model.id,
      teacher_id: teacher.id,
      course_id: course.id
    )
  end

  let(:invalid_attributes) do
    attributes_for(
      :teacher_assignment,
      subject_id: subject_model.id,
      teacher_id: nil,
      course_id: course.id
    )
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      TeacherAssignment.create! valid_attributes
      get teacher_assignments_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      teacher_assignment = TeacherAssignment.create! valid_attributes
      get teacher_assignment_url(teacher_assignment)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_teacher_assignment_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      teacher_assignment = TeacherAssignment.create! valid_attributes
      get edit_teacher_assignment_url(teacher_assignment)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new TeacherAssignment' do
        expect do
          post teacher_assignments_url, params: { teacher_assignment: valid_attributes }
        end.to change(TeacherAssignment, :count).by(1)
      end

      it 'redirects to the created teacher_assignment' do
        post teacher_assignments_url, params: { teacher_assignment: valid_attributes }
        expect(response).to redirect_to(teacher_assignment_url(TeacherAssignment.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new TeacherAssignment' do
        expect do
          post teacher_assignments_url, params: { teacher_assignment: invalid_attributes }
        end.not_to change(TeacherAssignment, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post teacher_assignments_url, params: { teacher_assignment: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_teacher) { create(:teacher) }
      let(:new_attributes) do
        attributes_for(
          :teacher_assignment,
          subject_id: subject_model.id,
          teacher_id: new_teacher.id,
          course_id: course.id
        )
      end

      it 'updates the requested teacher_assignment' do
        teacher_assignment = TeacherAssignment.create! valid_attributes
        patch teacher_assignment_url(teacher_assignment), params: { teacher_assignment: new_attributes }
        teacher_assignment.reload
        expect(teacher_assignment.teacher_id).to eq(new_teacher.id)
      end

      it 'redirects to the teacher_assignment' do
        teacher_assignment = TeacherAssignment.create! valid_attributes
        patch teacher_assignment_url(teacher_assignment), params: { teacher_assignment: new_attributes }
        teacher_assignment.reload
        expect(response).to redirect_to(teacher_assignment_url(teacher_assignment))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        teacher_assignment = TeacherAssignment.create! valid_attributes
        patch teacher_assignment_url(teacher_assignment), params: { teacher_assignment: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested teacher_assignment' do
      teacher_assignment = TeacherAssignment.create! valid_attributes
      expect do
        delete teacher_assignment_url(teacher_assignment)
      end.to change(TeacherAssignment, :count).by(-1)
    end

    it 'redirects to the teacher_assignments list' do
      teacher_assignment = TeacherAssignment.create! valid_attributes
      delete teacher_assignment_url(teacher_assignment)
      expect(response).to redirect_to(teacher_assignments_url)
    end
  end
end
