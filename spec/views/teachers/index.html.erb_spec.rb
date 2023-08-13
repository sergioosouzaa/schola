# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'teachers/index' do
  let(:teachers) { create_list(:teacher, 2) }

  before do
    assign(:teachers, teachers)
  end

  it 'renders a list of teachers' do
    render

    expect(rendered).to have_table(with_cols: [teachers.map(&:name)])
  end

  it 'renders actions links' do
    render

    expect(rendered).to have_selector('table tbody') do |table|
      expect(table).to have_selector('tr:nth-child(1) td:nth-child(4)') do |cell|
        expect(cell).to have_link('Show', href: teacher_path(teachers.first))
        expect(cell).to have_link('Edit', href: edit_teacher_path(teachers.first))
      end
      expect(table).to have_selector('tr:nth-child(2) td:nth-child(4)') do |cell|
        expect(cell).to have_link('Show', href: teacher_path(teachers.second))
        expect(cell).to have_link('Edit', href: edit_teacher_path(teachers.second))
      end
    end
  end
end
