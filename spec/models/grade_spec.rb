# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Grade do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to validate_numericality_of(:value).is_in(0.0..10.0) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:exam) }
    it { is_expected.to belong_to(:enrollment).with_foreign_key(:enrollment_code) }
  end
end
