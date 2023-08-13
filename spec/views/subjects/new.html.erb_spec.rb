# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'subjects/new' do
  let(:subject_model) { build(:subject) }

  before do
    assign(:subject, subject_model)
  end

  it 'renders new subject form' do
    render

    form_selector = format("form[action='%<action>s'][method='%<method>s']", action: subjects_path, method: 'post')
    expect(rendered).to have_selector(form_selector) do |form|
      expect(form).to have_field('subject[name]', type: 'text')
      expect(form).to have_button('Create Subject')
    end
  end
end
