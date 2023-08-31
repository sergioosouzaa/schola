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
    let!(:course_default_year) { create(:course, year: 2023) }
    let!(:course_old_year) { create(:course, year: 2021) }
    let!(:enrollments_default_year) { create_list(:enrollment, 2, course: course_default_year) }
    let!(:enrollments_old_year) { create_list(:enrollment, 2, course: course_old_year) }

    it 'renders a successful response' do
      Student.create! valid_attributes
      get students_url
      expect(response).to be_successful
    end

    context 'when no year is specified in the URI' do
      it 'renders only the enrollments for the default year', aggregate_failures: true do
        get students_url

        expect(response.body).to include(enrollments_default_year.first.code)
        expect(response.body).to include(enrollments_default_year.second.code)
        expect(response.body).not_to include(enrollments_old_year.first.code)
        expect(response.body).not_to include(enrollments_old_year.second.code)
      end

      it 'renders the names of the courses for the default year' do
        get students_url
        expect(response.body).to include(course_default_year.name)
      end
    end

    context 'when the year is specified on the URI' do
      it 'renders only the enrollments for the default year', aggregate_failures: true do
        get '/students?year=2021'

        expect(response.body).not_to include(enrollments_default_year.first.code)
        expect(response.body).not_to include(enrollments_default_year.second.code)
        expect(response.body).to include(enrollments_old_year.first.code)
        expect(response.body).to include(enrollments_old_year.second.code)
      end

      it 'renders the names of the courses for the default year' do
        get '/students?year=2021'
        expect(response.body).to include(course_old_year.name)
      end
    end
  end

  describe 'GET /show' do
    let!(:student) { create(:student) }
    let!(:course) { create(:course, year: 2023) }
    let!(:enrollment) { create(:enrollment, course:, student:) }
    let!(:exam) { create(:exam, course:) }
    let!(:grades) { create_list(:grade, 2, enrollment:, exam:) }

    context 'when the user has an enrollment on the year' do
      it 'renders a successful response' do
        get student_url(student)
        expect(response).to be_successful
      end

      it 'renders the student\'s name' do
        get student_url(student)
        expect(response.body).to include(student.name)
      end

      it 'renders the course name' do
        get student_url(student)
        expect(response.body).to include(course.name)
      end

      it 'renders the enrollment code' do
        get student_url(student)
        expect(response.body).to include(enrollment.code)
      end

      it 'renders the grades average', aggregate_failures: true do
        get student_url(student)
        expect(response.body).to include(exam.subject.name)
        expect(response.body).to include(format('%.02f', (grades.pluck(:value).sum / grades.count)))
      end
    end

    context 'when the user does not have an enrollment on the year' do
      it 'renders a successful response' do
        get "/students/#{student.id}?year=2021"
        expect(response).to be_successful
      end

      it 'renders the student name' do
        get "/students/#{student.id}?year=2021"
        expect(response.body).to include(student.name)
      end

      it 'renders that there are no enrollments for this year' do
        get "/students/#{student.id}?year=2021"
        expect(response.body).not_to include(enrollment.code)
      end

      it 'render that there are no courses this year' do
        get "/students/#{student.id}?year=2021"
        expect(response.body).not_to include(course.name)
      end

      it 'renders the alert flash message', aggregate_failures: true do
        get "/students/#{student.id}?year=2021"
        expect(flash[:alert]).to be_present
        expect(flash[:alert]).to eq('Student is not enrolled for this year.')
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
