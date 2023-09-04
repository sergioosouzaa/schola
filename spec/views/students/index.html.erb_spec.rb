# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'students/index' do
  let!(:students) { create_list(:student, 2) }
  let!(:course) { create(:course, year: 2023) }
  let!(:enrollment_first) { create(:enrollment, course:, student: students.first) }
  let!(:enrollment_second) { create(:enrollment, course:, student: students.second) }

  before do
    assign(:students, Student.with_enrollment_details_from_year('2023'))
  end

  it 'renders a table of students' do
    render

    expect(rendered).to have_table(with_cols: [students.pluck(:name)])
  end

  it 'renders actions links' do
    render

    expect(rendered).to have_selector('table tbody') do |table|
      expect(table).to have_selector('tr:nth-child(1) td:nth-child(4)') do |cell|
        expect(cell).to have_link('Show', href: student_path(students.first))
        expect(cell).to have_link('Edit', href: edit_student_path(students.first))
      end
      expect(table).to have_selector('tr:nth-child(2) td:nth-child(4)') do |cell|
        expect(cell).to have_link('Show', href: student_path(students.second))
        expect(cell).to have_link('Edit', href: edit_student_path(students.second))
      end
    end
  end
end
