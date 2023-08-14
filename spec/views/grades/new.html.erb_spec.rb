# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'grades/new' do
  let!(:enrollments) { create_list(:enrollment, 3) }
  let!(:exams) { create_list(:exam, 3) }

  before do
    assign(:grade, build(:grade))
  end

  it 'renders new grade form' do
    render

    form_selector = format("form[action='%<action>s'][method='%<method>s']", action: grades_path, method: 'post')
    expect(rendered).to have_selector(form_selector) do |form|
      expect(form).to have_select(
        'grade[enrollment_code]',
        with_options: enrollments.map { |e| "#{e.code} - #{e.student.name}" }
      )
      expect(form).to have_select(
        'grade[exam_id]',
        with_options: exams.map { |e| "#{e.subject.name} - #{e.realized_on}" }
      )
      expect(form).to have_field('grade[value]', type: 'number')
      expect(form).to have_button('Create Grade')
    end
  end
end
