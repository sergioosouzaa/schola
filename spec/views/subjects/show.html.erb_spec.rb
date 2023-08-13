# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'subjects/show' do
  let(:subject_model) { create(:subject) }

  before do
    assign(:subject, subject_model)
  end

  it 'renders attributes in <p>' do
    render

    expect(rendered).to have_selector('p:nth-child(1)') do |p|
      expect(p).to have_content('Name:')
      expect(p).to have_content(subject_model.name)
    end
  end

  it 'renders actions' do
    render

    form_selector = format(
      "form[action='%<action>s'][method='%<method>s']",
      action: subject_path(subject_model),
      method: 'post'
    )
    expect(rendered).to have_link('Edit this subject', href: edit_subject_path(subject_model))
    expect(rendered).to have_selector(form_selector) do |form|
      expect(form).to have_field('_method', type: 'hidden', with: 'delete')
      expect(form).to have_button('Destroy this subject')
    end
  end
end
