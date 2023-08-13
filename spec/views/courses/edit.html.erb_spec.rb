# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'courses/edit' do
  let(:course) { create(:course) }

  before do
    assign(:course, course)
  end

  it 'renders new course form' do
    render

    form_selector = format(
      "form[action='%<action>s'][method='%<method>s']",
      action: course_path(course),
      method: 'post'
    )
    expect(rendered).to have_selector(form_selector) do |form|
      expect(form).to have_field('course[name]', type: 'text')
      expect(form).to have_field('course[year]', type: 'number')
      expect(form).to have_field('course[starts_on]', type: 'date')
      expect(form).to have_field('course[ends_on]', type: 'date')
      expect(form).to have_button('Update Course')
    end
  end
end
