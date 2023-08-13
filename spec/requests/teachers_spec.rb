# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/teachers' do
  let(:valid_attributes) do
    { name: 'Albert Einstein' }
  end

  let(:invalid_attributes) do
    { name: nil }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Teacher.create! valid_attributes
      get teachers_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      teacher = Teacher.create! valid_attributes
      get teacher_url(teacher)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_teacher_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      teacher = Teacher.create! valid_attributes
      get edit_teacher_url(teacher)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Teacher' do
        expect do
          post teachers_url, params: { teacher: valid_attributes }
        end.to change(Teacher, :count).by(1)
      end

      it 'redirects to the created teacher' do
        post teachers_url, params: { teacher: valid_attributes }
        expect(response).to redirect_to(teacher_url(Teacher.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Teacher' do
        expect do
          post teachers_url, params: { teacher: invalid_attributes }
        end.not_to change(Teacher, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post teachers_url, params: { teacher: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { name: 'Niels Bohr' }
      end

      it 'updates the requested teacher' do
        teacher = Teacher.create! valid_attributes
        patch teacher_url(teacher), params: { teacher: new_attributes }
        teacher.reload
        expect(teacher.name).to eq('Niels Bohr')
      end

      it 'redirects to the teacher' do
        teacher = Teacher.create! valid_attributes
        patch teacher_url(teacher), params: { teacher: new_attributes }
        teacher.reload
        expect(response).to redirect_to(teacher_url(teacher))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        teacher = Teacher.create! valid_attributes
        patch teacher_url(teacher), params: { teacher: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested teacher' do
      teacher = Teacher.create! valid_attributes
      expect do
        delete teacher_url(teacher)
      end.to change(Teacher, :count).by(-1)
    end

    it 'redirects to the teachers list' do
      teacher = Teacher.create! valid_attributes
      delete teacher_url(teacher)
      expect(response).to redirect_to(teachers_url)
    end
  end
end
