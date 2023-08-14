# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Enrollment do
  subject(:enrollment) { build(:enrollment) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_uniqueness_of(:code) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:student) }
    it { is_expected.to belong_to(:course) }
  end
end
