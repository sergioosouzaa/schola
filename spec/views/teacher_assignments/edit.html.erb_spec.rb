# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'teacher_assignments/edit' do
  let!(:teachers) { create_list(:teacher, 3) }
  let!(:subjects) { create_list(:subject, 3) }
  let!(:courses) { create_list(:course, 3) }

  let(:assignment) do
    create(
      :teacher_assignment,
      teacher: teachers.sample,
      subject: subjects.sample,
      course: courses.sample
    )
  end

  before do
    assign(:teacher_assignment, assignment)
  end

  it 'renders new teacher_assignment form' do
    render

    form_selector = format(
      "form[action='%<action>s'][method='%<method>s']",
      action: teacher_assignment_path(assignment),
      method: 'post'
    )
    expect(rendered).to have_selector(form_selector) do |form|
      expect(form).to have_select(
        'teacher_assignment[course_id]',
        with_options: courses.map { |c| "#{c.year} - #{c.name}" },
        selected: "#{assignment.course.year} - #{assignment.course.name}"
      )
      expect(form).to have_select(
        'teacher_assignment[teacher_id]',
        with_options: teachers.map(&:name),
        selected: assignment.teacher.name
      )
      expect(form).to have_select(
        'teacher_assignment[subject_id]',
        with_options: subjects.map(&:name),
        selected: assignment.subject.name
      )
      expect(form).to have_button('Update Assignment')
    end
  end
end
