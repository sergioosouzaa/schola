# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'grades/index' do
  let(:grades) { create_list(:grade, 2) }

  before do
    assign(:grades, grades)
  end

  it 'renders a table of grades' do
    render

    grades_data = grades.map do |grade|
      ["#{grade.enrollment.code} - #{grade.enrollment.student.name}",
       grade.exam.subject.name,
       format('%.02f', grade.value)]
    end
    expect(rendered).to have_table(with_rows: grades_data)
  end

  it 'renders actions links' do
    render

    expect(rendered).to have_selector('table tbody') do |table|
      expect(table).to have_selector('tr:nth-child(1) td:nth-child(4)') do |cell|
        expect(cell).to have_link('Show', href: grade_path(grades.first))
        expect(cell).to have_link('Edit', href: edit_grade_path(grades.first))
      end
      expect(table).to have_selector('tr:nth-child(2) td:nth-child(4)') do |cell|
        expect(cell).to have_link('Show', href: grade_path(grades.second))
        expect(cell).to have_link('Edit', href: edit_grade_path(grades.second))
      end
    end
  end
end
