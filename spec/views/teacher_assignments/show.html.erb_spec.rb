# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'teacher_assignments/show' do
  let(:assignment) { create(:teacher_assignment) }

  before do
    assign(:teacher_assignment, assignment)
  end

  it 'renders attributes in <p>' do
    render

    expect(rendered).to have_selector('p:nth-child(1)') do |p|
      expect(p).to have_content('Teacher:')
      expect(p).to have_content(assignment.teacher.name)
    end

    expect(rendered).to have_selector('p:nth-child(2)') do |p|
      expect(p).to have_content('Subject:')
      expect(p).to have_content(assignment.subject.name)
    end

    expect(rendered).to have_selector('p:nth-child(3)') do |p|
      expect(p).to have_content('Course:')
      expect(p).to have_content("#{assignment.course.year} - #{assignment.course.name}")
    end
  end

  it 'renders actions' do
    render

    form_selector = format(
      "form[action='%<action>s'][method='%<method>s']",
      action: teacher_assignment_path(assignment),
      method: 'post'
    )
    expect(rendered).to have_link('Edit this assignment', href: edit_teacher_assignment_path(assignment))
    expect(rendered).to have_selector(form_selector) do |form|
      expect(form).to have_field('_method', type: 'hidden', with: 'delete')
      expect(form).to have_button('Destroy this assignment')
    end
  end
end
