# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TeacherAssignment do
  describe 'associations' do
    it { is_expected.to belong_to(:teacher) }
    it { is_expected.to belong_to(:course) }
    it { is_expected.to belong_to(:subject) }
  end
end
