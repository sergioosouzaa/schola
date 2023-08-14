# frozen_string_literal: true

class Exam < ApplicationRecord
  validates :realized_on, presence: true

  belongs_to :course
  belongs_to :subject
end
