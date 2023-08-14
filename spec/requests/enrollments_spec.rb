# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/enrollments' do
  let(:student) { create(:student) }
  let(:course) { create(:course) }
  let(:valid_attributes) { attributes_for(:enrollment, student_id: student.id, course_id: course.id) }
  let(:invalid_attributes) { attributes_for(:enrollment, student_id: student.id, course_id: course.id, code: nil) }

  describe 'GET /index' do
    it 'renders a successful response' do
      Enrollment.create! valid_attributes
      get enrollments_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      enrollment = Enrollment.create! valid_attributes
      get enrollment_url(enrollment)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_enrollment_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      enrollment = Enrollment.create! valid_attributes
      get edit_enrollment_url(enrollment)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Enrollment' do
        expect do
          post enrollments_url, params: { enrollment: valid_attributes }
        end.to change(Enrollment, :count).by(1)
      end

      it 'redirects to the created enrollment' do
        post enrollments_url, params: { enrollment: valid_attributes }
        expect(response).to redirect_to(enrollment_url(Enrollment.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Enrollment' do
        expect do
          post enrollments_url, params: { enrollment: invalid_attributes }
        end.not_to change(Enrollment, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post enrollments_url, params: { enrollment: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:other_course) { create(:course) }
      let(:new_attributes) do
        { course_id: other_course.id }
      end

      it 'updates the requested enrollment' do
        enrollment = Enrollment.create! valid_attributes
        patch enrollment_url(enrollment), params: { enrollment: new_attributes }
        enrollment.reload
        expect(enrollment.course_id).to eq(other_course.id)
      end

      it 'redirects to the enrollment' do
        enrollment = Enrollment.create! valid_attributes
        patch enrollment_url(enrollment), params: { enrollment: new_attributes }
        enrollment.reload
        expect(response).to redirect_to(enrollment_url(enrollment))
      end
    end

    context 'with invalid parameters' do
      let(:invalid_new_attributes) do
        { course_id: nil }
      end

      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        enrollment = Enrollment.create! valid_attributes
        patch enrollment_url(enrollment), params: { enrollment: invalid_new_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested enrollment' do
      enrollment = Enrollment.create! valid_attributes
      expect do
        delete enrollment_url(enrollment)
      end.to change(Enrollment, :count).by(-1)
    end

    it 'redirects to the enrollments list' do
      enrollment = Enrollment.create! valid_attributes
      delete enrollment_url(enrollment)
      expect(response).to redirect_to(enrollments_url)
    end
  end
end
