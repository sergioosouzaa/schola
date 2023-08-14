# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Exam do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:realized_on) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:subject) }
    it { is_expected.to belong_to(:course) }
  end
end
