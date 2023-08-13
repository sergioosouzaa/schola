# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'courses/new' do
  before do
    assign(:course, build(:course))
  end

  it 'renders new course form' do
    render

    form_selector = format(
      "form[action='%<action>s'][method='%<method>s']",
      action: courses_path,
      method: 'post'
    )
    expect(rendered).to have_selector(form_selector) do |form|
      expect(form).to have_field('course[name]', type: 'text')
      expect(form).to have_field('course[year]', type: 'number')
      expect(form).to have_field('course[starts_on]', type: 'date')
      expect(form).to have_field('course[ends_on]', type: 'date')
      expect(form).to have_button('Create Course')
    end
  end
end
