# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'enrollments/show' do
  let(:enrollment) { create(:enrollment) }

  before do
    assign(:enrollment, enrollment)
  end

  it 'renders attributes in <p>' do
    render

    expect(rendered).to have_selector('p:nth-child(1)') do |p|
      expect(p).to have_content('Code:')
      expect(p).to have_content(enrollment.code)
    end

    expect(rendered).to have_selector('p:nth-child(2)') do |p|
      expect(p).to have_content('Student:')
      expect(p).to have_content(enrollment.student.name)
    end

    expect(rendered).to have_selector('p:nth-child(3)') do |p|
      expect(p).to have_content('Course:')
      expect(p).to have_content("#{enrollment.course.year} - #{enrollment.course.name}")
    end
  end

  it 'renders actions' do
    render

    form_selector = format(
      "form[action='%<action>s'][method='%<method>s']",
      action: enrollment_path(enrollment),
      method: 'post'
    )
    expect(rendered).to have_link('Edit this enrollment', href: edit_enrollment_path(enrollment))
    expect(rendered).to have_selector(form_selector) do |form|
      expect(form).to have_field('_method', type: 'hidden', with: 'delete')
      expect(form).to have_button('Destroy this enrollment')
    end
  end
end
