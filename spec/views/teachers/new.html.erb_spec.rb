# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'teachers/new' do
  let(:teacher) { build(:teacher) }

  before do
    assign(:teacher, teacher)
  end

  it 'renders new teacher form' do
    render

    form_selector = format("form[action='%<action>s'][method='%<method>s']", action: teachers_path, method: 'post')
    expect(rendered).to have_selector(form_selector) do |form|
      expect(form).to have_field('teacher[name]', type: 'text')
      expect(form).to have_button('Create Teacher')
    end
  end
end
