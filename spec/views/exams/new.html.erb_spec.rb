# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'exams/new' do
  let!(:subjects) { create_list(:subject, 3) }
  let!(:courses) { create_list(:course, 3) }

  before do
    assign(:exam, build(:exam))
  end

  it 'renders new exam form' do
    render

    form_selector = format("form[action='%<action>s'][method='%<method>s']", action: exams_path, method: 'post')
    expect(rendered).to have_selector(form_selector) do |form|
      expect(form).to have_select(
        'exam[subject_id]',
        with_options: subjects.map(&:name)
      )
      expect(form).to have_select(
        'exam[course_id]',
        with_options: courses.map { |course| "#{course.year} - #{course.name}" }
      )
      expect(form).to have_field('exam[realized_on]', type: 'date')
      expect(form).to have_button('Create Exam')
    end
  end
end
