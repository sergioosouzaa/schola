# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'exams/index' do
  let(:exams) { create_list(:exam, 2) }

  before do
    assign(:exams, exams)
  end

  it 'renders a table of exams' do
    render

    exams_data = exams.map do |exam|
      ["#{exam.course.year} - #{exam.course.name}", exam.subject.name, exam.realized_on.to_s]
    end
    expect(rendered).to have_table(with_rows: exams_data)
  end

  it 'renders actions links' do
    render

    expect(rendered).to have_selector('table tbody') do |table|
      expect(table).to have_selector('tr:nth-child(1) td:nth-child(4)') do |cell|
        expect(cell).to have_link('Show', href: exam_path(exams.first))
        expect(cell).to have_link('Edit', href: edit_exam_path(exams.first))
      end
      expect(table).to have_selector('tr:nth-child(2) td:nth-child(4)') do |cell|
        expect(cell).to have_link('Show', href: exam_path(exams.second))
        expect(cell).to have_link('Edit', href: edit_exam_path(exams.second))
      end
    end
  end
end
