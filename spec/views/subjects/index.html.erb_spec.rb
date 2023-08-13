# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'subjects/index' do
  let(:subjects) { create_list(:subject, 2) }

  before do
    assign(:subjects, subjects)
  end

  it 'renders a list of subjects' do
    render

    expect(rendered).to have_table(with_cols: [subjects.map(&:name)])
  end

  it 'renders actions links' do
    render

    expect(rendered).to have_selector('table tbody') do |table|
      expect(table).to have_selector('tr:nth-child(1) td:nth-child(2)') do |cell|
        expect(cell).to have_link('Show', href: subject_path(subjects.first))
        expect(cell).to have_link('Edit', href: edit_subject_path(subjects.first))
      end
      expect(table).to have_selector('tr:nth-child(2) td:nth-child(2)') do |cell|
        expect(cell).to have_link('Show', href: subject_path(subjects.second))
        expect(cell).to have_link('Edit', href: edit_subject_path(subjects.second))
      end
    end
  end
end
