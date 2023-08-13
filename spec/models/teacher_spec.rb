# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Teacher do
  describe 'validations' do
    subject(:teacher) { build(:teacher) }

    it { is_expected.to validate_presence_of(:name) }
  end
end
