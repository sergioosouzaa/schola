# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/exams' do
  let(:course) { create(:course) }
  let(:subject_model) { create(:subject) }
  let(:valid_attributes) do
    attributes_for(:exam, course_id: course.id, subject_id: subject_model.id)
  end

  let(:invalid_attributes) do
    attributes_for(:exam, course_id: nil, subject_id: subject_model.id)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Exam.create! valid_attributes
      get exams_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      exam = Exam.create! valid_attributes
      get exam_url(exam)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_exam_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      exam = Exam.create! valid_attributes
      get edit_exam_url(exam)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Exam' do
        expect do
          post exams_url, params: { exam: valid_attributes }
        end.to change(Exam, :count).by(1)
      end

      it 'redirects to the created exam' do
        post exams_url, params: { exam: valid_attributes }
        expect(response).to redirect_to(exam_url(Exam.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Exam' do
        expect do
          post exams_url, params: { exam: invalid_attributes }
        end.not_to change(Exam, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post exams_url, params: { exam: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_realization_date) { rand(course.starts_on..course.ends_on) }
      let(:new_attributes) do
        { realized_on: new_realization_date }
      end

      it 'updates the requested exam' do
        exam = Exam.create! valid_attributes
        patch exam_url(exam), params: { exam: new_attributes }
        exam.reload
        expect(exam.realized_on).to eq(new_realization_date)
      end

      it 'redirects to the exam' do
        exam = Exam.create! valid_attributes
        patch exam_url(exam), params: { exam: new_attributes }
        exam.reload
        expect(response).to redirect_to(exam_url(exam))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        exam = Exam.create! valid_attributes
        patch exam_url(exam), params: { exam: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested exam' do
      exam = Exam.create! valid_attributes
      expect do
        delete exam_url(exam)
      end.to change(Exam, :count).by(-1)
    end

    it 'redirects to the exams list' do
      exam = Exam.create! valid_attributes
      delete exam_url(exam)
      expect(response).to redirect_to(exams_url)
    end
  end
end
