# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'exams/edit' do
  let!(:subjects) { create_list(:subject, 3) }
  let!(:courses) { create_list(:course, 3) }
  let(:exam) { create(:exam, subject: subjects.sample, course: courses.sample) }

  before do
    assign(:exam, exam)
  end

  it 'renders new exam form' do
    render

    form_selector = format("form[action='%<action>s'][method='%<method>s']", action: exam_path(exam), method: 'post')
    expect(rendered).to have_selector(form_selector) do |form|
      expect(form).to have_select(
        'exam[subject_id]',
        with_options: subjects.map(&:name),
        selected: exam.subject.name
      )
      expect(form).to have_select(
        'exam[course_id]',
        with_options: courses.map { |course| "#{course.year} - #{course.name}" },
        selected: "#{exam.course.year} - #{exam.course.name}"
      )
      expect(form).to have_field('exam[realized_on]', type: 'date')
      expect(form).to have_button('Update Exam')
    end
  end
end
