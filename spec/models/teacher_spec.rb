# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Teacher do
  describe 'validations' do
    subject(:teacher) { build(:teacher) }

    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:teacher_assignments).dependent(:destroy) }
    it { is_expected.to have_many(:courses).through(:teacher_assignments) }
    it { is_expected.to have_many(:subjects).through(:teacher_assignments) }
  end
end
