# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'teacher_assignments/index' do
  let(:teacher_assignments) { create_list(:teacher_assignment, 2) }

  before do
    assign(:teacher_assignments, teacher_assignments)
  end

  it 'renders a table of teacher_assignments' do
    render

    teacher_assignments_data = teacher_assignments.map do |teacher_assignment|
      [
        teacher_assignment.teacher.name,
        "#{teacher_assignment.course.year} - #{teacher_assignment.course.name}",
        teacher_assignment.subject.name
      ]
    end
    expect(rendered).to have_table(with_rows: teacher_assignments_data)
  end

  it 'renders actions links' do
    render

    expect(rendered).to have_selector('table tbody') do |table|
      expect(table).to have_selector('tr:nth-child(1) td:nth-child(4)') do |cell|
        expect(cell).to have_link('Show', href: teacher_assignment_path(teacher_assignments.first))
        expect(cell).to have_link('Edit', href: edit_teacher_assignment_path(teacher_assignments.first))
      end
      expect(table).to have_selector('tr:nth-child(2) td:nth-child(4)') do |cell|
        expect(cell).to have_link('Show', href: teacher_assignment_path(teacher_assignments.second))
        expect(cell).to have_link('Edit', href: edit_teacher_assignment_path(teacher_assignments.second))
      end
    end
  end
end
