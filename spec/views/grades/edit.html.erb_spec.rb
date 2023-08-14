# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'grades/edit' do
  let!(:enrollments) { create_list(:enrollment, 3) }
  let!(:exams) { create_list(:exam, 3) }
  let(:grade) { create(:grade, enrollment: enrollments.sample, exam: exams.sample) }

  before do
    assign(:grade, grade)
  end

  it 'renders new grade form' do
    render

    form_selector = format("form[action='%<action>s'][method='%<method>s']", action: grade_path(grade), method: 'post')
    expect(rendered).to have_selector(form_selector) do |form|
      expect(form).to have_select(
        'grade[enrollment_code]',
        with_options: enrollments.map { |e| "#{e.code} - #{e.student.name}" },
        selected: "#{grade.enrollment.code} - #{grade.enrollment.student.name}"
      )
      expect(form).to have_select(
        'grade[exam_id]',
        with_options: exams.map { |e| "#{e.subject.name} - #{e.realized_on}" },
        selected: "#{grade.exam.subject.name} - #{grade.exam.realized_on}"
      )
      expect(form).to have_field('grade[value]', type: 'number')
      expect(form).to have_button('Update Grade')
    end
  end
end
