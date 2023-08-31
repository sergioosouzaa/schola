# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/students' do
  let(:valid_attributes) do
    {
      name: 'Jon Snow',
      born_on: '1995-10-8'
    }
  end

  let(:invalid_attributes) do
    {
      name: nil,
      born_on: '1995-10-8'
    }
  end

  describe 'GET /index' do
    let!(:course) { create(:course, year: 2023) }
    let!(:enrollment) { create(:enrollment, course:) }

    it 'renders a successful response' do
      Student.create! valid_attributes
      get students_url
      expect(response).to be_successful
    end

    context 'when user has an enrollment on year' do
      it 'renders the enrollments' do
        get students_url
        expect(response.body).to include(enrollment.code)
      end

      it 'renders the course name' do
        get students_url
        expect(response.body).to include(course.name)
      end
    end

    context 'when user does not have an enrollment on year' do
      let!(:course) { create(:course, year: 2012) }
      let!(:enrollment) { create(:enrollment, course:) }

      it 'renders the message that user does not have an enrollment' do
        get students_url
        expect(response.body).to include('No enrollments on this year')
      end

      it 'renders the message that user does not have a course' do
        get students_url
        expect(response.body).to include('No course on this year')
      end
    end
  end

  describe 'GET /show' do
    context 'when the user has an enrollment on the year' do
      let!(:student) { create(:student) }
      let!(:course) { create(:course, year: 2023) }
      let!(:enrollment) { create(:enrollment, course:, student:) }
      let!(:exam) { create(:exam, course:) }
      let!(:grades) { create_list(:grade, 2, enrollment:, exam:) }

      it 'renders a successful response' do
        get student_url(student)
        expect(response).to be_successful
      end

      it 'renders the student name' do
        get student_url(student)
        expect(response.body).to include(student.name)
      end

      it 'renders the course name' do
        get student_url(student)
        expect(response.body).to include(course.name)
      end

      it 'renders the enrollment name' do
        get student_url(student)
        expect(response.body).to include(enrollment.code)
      end

      it 'renders the grades name', aggregate_failures: true do
        get student_url(student)
        expect(response.body).to include(exam.subject.name)
        expect(response.body).to include(format('%.02f', (grades.pluck(:value).sum / grades.count)))
      end
    end

    context 'when the user does not have an enrollment on the year' do
      let!(:student) { create(:student) }
      let!(:course) { create(:course, year: 2012) }
      let!(:enrollment) { create(:enrollment, course:, student:) }
      let!(:exam) { create(:exam, course:) }
      let!(:grades) { create_list(:grade, 2, enrollment:, exam:) }

      it 'renders a successful response' do
        get student_url(student)
        expect(response).to be_successful
      end

      it 'renders the student name' do
        get student_url(student)
        expect(response.body).to include(student.name)
      end

      it 'renders the course name' do
        get student_url(student)
        expect(response.body).to include('No enrollment on this year')
      end

      it 'renders the enrollment name' do
        get student_url(student)
        expect(response.body).to include('No courses on this year')
      end

      it 'renders the error flash message' do
        get student_url(student)
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_student_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      student = Student.create! valid_attributes
      get edit_student_url(student)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Student' do
        expect do
          post students_url, params: { student: valid_attributes }
        end.to change(Student, :count).by(1)
      end

      it 'redirects to the created student' do
        post students_url, params: { student: valid_attributes }
        expect(response).to redirect_to(student_url(Student.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Student' do
        expect do
          post students_url, params: { student: invalid_attributes }
        end.not_to change(Student, :count)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post students_url, params: { student: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          name: 'Daenerys Targaryen',
          born_on: '1996-3-15'
        }
      end

      it 'updates the requested student' do
        student = Student.create! valid_attributes
        patch student_url(student), params: { student: new_attributes }
        student.reload
        expect(student.name).to eq('Daenerys Targaryen')
      end

      it 'redirects to the student' do
        student = Student.create! valid_attributes
        patch student_url(student), params: { student: new_attributes }
        student.reload
        expect(response).to redirect_to(student_url(student))
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        student = Student.create! valid_attributes
        patch student_url(student), params: { student: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested student' do
      student = Student.create! valid_attributes
      expect do
        delete student_url(student)
      end.to change(Student, :count).by(-1)
    end

    it 'redirects to the students list' do
      student = Student.create! valid_attributes
      delete student_url(student)
      expect(response).to redirect_to(students_url)
    end
  end
end
