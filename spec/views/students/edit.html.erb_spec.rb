# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'students/edit' do
  let(:student) do
    create(:student)
  end

  before do
    assign(:student, student)
  end

  it 'renders the edit student form' do
    render

    form_selector = format(
      "form[action='%<action>s'][method='%<method>s']",
      action: student_path(student),
      method: 'post'
    )
    expect(rendered).to have_selector(form_selector) do |form|
      expect(form).to have_field('student[name]', type: 'text')
      expect(form).to have_field('student[born_on]', type: 'date')
      expect(form).to have_button('Update Student')
    end
  end
end
