# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'exams/show' do
  let(:exam) { create(:exam) }

  before do
    assign(:exam, exam)
  end

  it 'renders attributes in <p>' do
    render

    expect(rendered).to have_selector('p:nth-child(1)') do |p|
      expect(p).to have_content('Course:')
      expect(p).to have_content("#{exam.course.year} - #{exam.course.name}")
    end

    expect(rendered).to have_selector('p:nth-child(2)') do |p|
      expect(p).to have_content('Subject:')
      expect(p).to have_content(exam.subject.name)
    end

    expect(rendered).to have_selector('p:nth-child(3)') do |p|
      expect(p).to have_content('Realized on:')
      expect(p).to have_content(exam.realized_on)
    end
  end

  it 'renders actions' do
    render

    form_selector = format(
      "form[action='%<action>s'][method='%<method>s']",
      action: exam_path(exam),
      method: 'post'
    )
    expect(rendered).to have_link('Edit this exam', href: edit_exam_path(exam))
    expect(rendered).to have_selector(form_selector) do |form|
      expect(form).to have_field('_method', type: 'hidden', with: 'delete')
      expect(form).to have_button('Destroy this exam')
    end
  end
end
