# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'courses/show' do
  let(:course) { create(:course) }

  before do
    assign(:course, course)
  end

  it 'renders attributes in <p>' do
    render

    expect(rendered).to have_selector('p:nth-child(1)') do |p|
      expect(p).to have_content('Name:')
      expect(p).to have_content(course.name)
    end

    expect(rendered).to have_selector('p:nth-child(2)') do |p|
      expect(p).to have_content('Year:')
      expect(p).to have_content(course.year)
    end

    expect(rendered).to have_selector('p:nth-child(3)') do |p|
      expect(p).to have_content('Starts on:')
      expect(p).to have_content(course.starts_on)
    end

    expect(rendered).to have_selector('p:nth-child(4)') do |p|
      expect(p).to have_content('Ends on:')
      expect(p).to have_content(course.ends_on)
    end
  end

  it 'renders actions' do
    render

    form_selector = format(
      "form[action='%<action>s'][method='%<method>s']",
      action: course_path(course),
      method: 'post'
    )
    expect(rendered).to have_link('Edit this course', href: edit_course_path(course))
    expect(rendered).to have_selector(form_selector) do |form|
      expect(form).to have_field('_method', type: 'hidden', with: 'delete')
      expect(form).to have_button('Destroy this course')
    end
  end
end
