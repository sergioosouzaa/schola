# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'enrollments/new' do
  let!(:students) { create_list(:student, 3) }
  let!(:courses) { create_list(:course, 3) }

  before do
    assign(:enrollment, build(:enrollment))
  end

  it 'renders new enrollment form' do
    render

    form_selector = format("form[action='%<action>s'][method='%<method>s']", action: enrollments_path, method: 'post')
    expect(rendered).to have_selector(form_selector) do |form|
      expect(form).to have_field('enrollment[code]', type: 'text')
      expect(form).to have_select(
        'enrollment[student_id]',
        with_options: students.map(&:name)
      )
      expect(form).to have_select(
        'enrollment[course_id]',
        with_options: courses.map { |course| "#{course.year} - #{course.name}" }
      )
      expect(form).to have_button('Create Enrollment')
    end
  end
end
