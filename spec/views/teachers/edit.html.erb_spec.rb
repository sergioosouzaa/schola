# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'teachers/edit' do
  let(:teacher) { create(:teacher) }

  before do
    assign(:teacher, teacher)
  end

  it 'renders the edit teacher form' do
    render

    form_selector = format(
      "form[action='%<action>s'][method='%<method>s']",
      action: teacher_path(teacher),
      method: 'post'
    )
    expect(rendered).to have_selector(form_selector) do |form|
      expect(form).to have_field('teacher[name]', type: 'text')
      expect(form).to have_button('Update Teacher')
    end
  end
end
