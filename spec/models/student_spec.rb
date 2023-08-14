# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:born_on) }

    describe 'for born_on' do
      around do |example|
        travel_to(Date.new(2022, 5, 15), &example)
      end

      context 'when student was born in the past' do
        subject(:student) { build(:student, born_on: Date.new(2010, 8, 23)).tap(&:valid?) }

        it { is_expected.to be_valid }
        it { expect(student.errors[:born_on]).to be_empty }
      end

      context 'when student will be born in the future' do
        subject(:student) { build(:student, born_on: Date.new(2024, 8, 23)).tap(&:valid?) }

        it { is_expected.not_to be_valid }
        it { expect(student.errors[:born_on]).to include('must be less than 2022-05-15') }
      end

      context 'when student has born today' do
        subject(:student) { build(:student, born_on: Date.new(2022, 5, 15)).tap(&:valid?) }

        it { is_expected.not_to be_valid }
        it { expect(student.errors[:born_on]).to include('must be less than 2022-05-15') }
      end
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:enrollments).dependent(:destroy) }
  end
end
