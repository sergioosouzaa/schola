# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'subjects/edit' do
  let(:subject_model) { create(:subject) }

  before do
    assign(:subject, subject_model)
  end

  it 'renders the edit subject form' do
    render

    form_selector = format(
      "form[action='%<action>s'][method='%<method>s']",
      action: subject_path(subject_model),
      method: 'post'
    )
    expect(rendered).to have_selector(form_selector) do |form|
      expect(form).to have_field('subject[name]', type: 'text')
      expect(form).to have_button('Update Subject')
    end
  end
end
