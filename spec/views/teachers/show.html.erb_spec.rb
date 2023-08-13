# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'teachers/show' do
  let(:teacher) { create(:teacher) }

  before do
    assign(:teacher, teacher)
  end

  it 'renders attributes in <p>' do
    render

    expect(rendered).to have_selector('p:nth-child(1)') do |p|
      expect(p).to have_content('Name:')
      expect(p).to have_content(teacher.name)
    end
  end

  it 'renders actions' do
    render

    form_selector = format(
      "form[action='%<action>s'][method='%<method>s']",
      action: teacher_path(teacher),
      method: 'post'
    )
    expect(rendered).to have_link('Edit this teacher', href: edit_teacher_path(teacher))
    expect(rendered).to have_selector(form_selector) do |form|
      expect(form).to have_field('_method', type: 'hidden', with: 'delete')
      expect(form).to have_button('Destroy this teacher')
    end
  end
end
