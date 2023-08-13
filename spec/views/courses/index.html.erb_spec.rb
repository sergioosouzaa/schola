# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'courses/index' do
  let(:courses) { create_list(:course, 2) }

  before do
    assign(:courses, courses)
  end

  it 'renders a table of courses' do
    render

    courses_data = courses.map do |course|
      [course.name, course.year.to_s, course.starts_on.to_s, course.ends_on.to_s]
    end
    expect(rendered).to have_table(with_rows: courses_data)
  end

  it 'renders actions links' do
    render

    expect(rendered).to have_selector('table tbody') do |table|
      expect(table).to have_selector('tr:nth-child(1) td:nth-child(5)') do |cell|
        expect(cell).to have_link('Show', href: course_path(courses.first))
        expect(cell).to have_link('Edit', href: edit_course_path(courses.first))
      end
      expect(table).to have_selector('tr:nth-child(2) td:nth-child(5)') do |cell|
        expect(cell).to have_link('Show', href: course_path(courses.second))
        expect(cell).to have_link('Edit', href: edit_course_path(courses.second))
      end
    end
  end
end
