# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/grades' do
  let(:enrollment) { create(:enrollment) }
  let(:exam) { create(:exam) }
  let(:valid_attributes) do
    attributes_for(:grade, enrollment_code: enrollment.code, exam_id: exam.id)
  end

  let(:invalid_attributes) do
    attributes_for(:grade, enrollment_code: enrollment.code, exam_id: exam.id, value: 13.5)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Grade.create! valid_attributes
      get grades_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      grade = Grade.create! valid_attributes
      get grade_url(grade)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_grade_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      grade = Grade.create! valid_attributes
      get edit_grade_url(grade)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Grade' do
        expect do
          post grades_url, params: { grade: valid_attributes }
        end.to change(Grade, :count).by(1)
      end

      it 'redirects to the created grade' do
        post grades_url, params: { grade: valid_attributes }
        expect(response).to redirect_to(grade_url(Grade.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Grade' do
        expect do
          post grades_url, params: { grade: invalid_attributes }
        end.not_to change(Grade, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post grades_url, params: { grade: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { value: 4.23 }
      end

      it 'updates the requested grade' do
        grade = Grade.create! valid_attributes
        patch grade_url(grade), params: { grade: new_attributes }
        grade.reload
        expect(grade.value).to eq(4.23)
      end

      it 'redirects to the grade' do
        grade = Grade.create! valid_attributes
        patch grade_url(grade), params: { grade: new_attributes }
        grade.reload
        expect(response).to redirect_to(grade_url(grade))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        grade = Grade.create! valid_attributes
        patch grade_url(grade), params: { grade: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested grade' do
      grade = Grade.create! valid_attributes
      expect do
        delete grade_url(grade)
      end.to change(Grade, :count).by(-1)
    end

    it 'redirects to the grades list' do
      grade = Grade.create! valid_attributes
      delete grade_url(grade)
      expect(response).to redirect_to(grades_url)
    end
  end
end
