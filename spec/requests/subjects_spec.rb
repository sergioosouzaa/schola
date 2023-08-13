# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/subjects' do
  let(:valid_attributes) do
    { name: 'math' }
  end

  let(:invalid_attributes) do
    { name: nil }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Subject.create! valid_attributes
      get subjects_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      subject = Subject.create! valid_attributes
      get subject_url(subject)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_subject_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      subject = Subject.create! valid_attributes
      get edit_subject_url(subject)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Subject' do
        expect do
          post subjects_url, params: { subject: valid_attributes }
        end.to change(Subject, :count).by(1)
      end

      it 'redirects to the created subject' do
        post subjects_url, params: { subject: valid_attributes }
        expect(response).to redirect_to(subject_url(Subject.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Subject' do
        expect do
          post subjects_url, params: { subject: invalid_attributes }
        end.not_to change(Subject, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post subjects_url, params: { subject: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        { name: 'biology' }
      end

      it 'updates the requested subject' do
        subject = Subject.create! valid_attributes
        patch subject_url(subject), params: { subject: new_attributes }
        subject.reload
        expect(subject.name).to eq('biology')
      end

      it 'redirects to the subject' do
        subject = Subject.create! valid_attributes
        patch subject_url(subject), params: { subject: new_attributes }
        subject.reload
        expect(response).to redirect_to(subject_url(subject))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        subject = Subject.create! valid_attributes
        patch subject_url(subject), params: { subject: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested subject' do
      subject = Subject.create! valid_attributes
      expect do
        delete subject_url(subject)
      end.to change(Subject, :count).by(-1)
    end

    it 'redirects to the subjects list' do
      subject = Subject.create! valid_attributes
      delete subject_url(subject)
      expect(response).to redirect_to(subjects_url)
    end
  end
end
