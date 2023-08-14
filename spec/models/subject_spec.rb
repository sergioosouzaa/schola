# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subject do
  describe 'validations' do
    subject(:model) { build(:subject) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:teacher_assignments).dependent(:destroy) }
    it { is_expected.to have_many(:teachers).through(:teacher_assignments) }
  end
end
