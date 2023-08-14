# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'grades/show' do
  let(:grade) { create(:grade) }

  before do
    assign(:grade, grade)
  end

  it 'renders attributes in <p>' do
    render

    expect(rendered).to have_selector('p:nth-child(1)') do |p|
      expect(p).to have_content('Enrollment:')
      expect(p).to have_content("#{grade.enrollment.code} - #{grade.enrollment.student.name}")
    end

    expect(rendered).to have_selector('p:nth-child(2)') do |p|
      expect(p).to have_content('Exam:')
      expect(p).to have_content("#{grade.exam.subject.name} - #{grade.exam.realized_on}")
    end

    expect(rendered).to have_selector('p:nth-child(3)') do |p|
      expect(p).to have_content('Value:')
      expect(p).to have_content(grade.value)
    end
  end

  it 'renders actions' do
    render

    form_selector = format(
      "form[action='%<action>s'][method='%<method>s']",
      action: grade_path(grade),
      method: 'post'
    )
    expect(rendered).to have_link('Edit this grade', href: edit_grade_path(grade))
    expect(rendered).to have_selector(form_selector) do |form|
      expect(form).to have_field('_method', type: 'hidden', with: 'delete')
      expect(form).to have_button('Destroy this grade')
    end
  end
end
