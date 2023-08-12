# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'students/show' do
  let(:student) { create(:student) }

  before do
    assign(:student, student)
  end

  it 'renders attributes in <p>' do
    render

    expect(rendered).to have_selector('p:nth-child(1)') do |p|
      expect(p).to have_content('Name:')
      expect(p).to have_content(student.name)
    end

    expect(rendered).to have_selector('p:nth-child(2)') do |p|
      expect(p).to have_content('Born on:')
      expect(p).to have_content(student.born_on)
    end
  end

  it 'renders actions' do
    render

    form_selector = format(
      "form[action='%<action>s'][method='%<method>s']",
      action: student_path(student),
      method: 'post'
    )
    expect(rendered).to have_link('Edit this student', href: edit_student_path(student))
    expect(rendered).to have_selector(form_selector) do |form|
      expect(form).to have_field('_method', type: 'hidden', with: 'delete')
      expect(form).to have_button('Destroy this student')
    end
  end
end
