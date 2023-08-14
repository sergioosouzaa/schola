# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'enrollments/index' do
  let(:enrollments) { create_list(:enrollment, 2) }

  before do
    assign(:enrollments, enrollments)
  end

  it 'renders a table of enrollments' do
    render

    enrollments_data = enrollments.map do |enrollment|
      [enrollment.code, enrollment.course.year.to_s, enrollment.student.name]
    end
    expect(rendered).to have_table(with_rows: enrollments_data)
  end

  it 'renders actions links' do
    render

    expect(rendered).to have_selector('table tbody') do |table|
      expect(table).to have_selector('tr:nth-child(1) td:nth-child(4)') do |cell|
        expect(cell).to have_link('Show', href: enrollment_path(enrollments.first))
        expect(cell).to have_link('Edit', href: edit_enrollment_path(enrollments.first))
      end
      expect(table).to have_selector('tr:nth-child(2) td:nth-child(4)') do |cell|
        expect(cell).to have_link('Show', href: enrollment_path(enrollments.second))
        expect(cell).to have_link('Edit', href: edit_enrollment_path(enrollments.second))
      end
    end
  end
end
