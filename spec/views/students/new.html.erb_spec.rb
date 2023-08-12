# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'students/new' do
  before do
    assign(:student, build(:student))
  end

  it 'renders new student form' do
    render

    form_selector = format("form[action='%<action>s'][method='%<method>s']", action: students_path, method: 'post')
    expect(rendered).to have_selector(form_selector) do |form|
      expect(form).to have_field('student[name]', type: 'text')
      expect(form).to have_field('student[born_on]', type: 'date')
      expect(form).to have_button('Create Student')
    end
  end
end
