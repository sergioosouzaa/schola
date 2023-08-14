# frozen_string_literal: true

class Enrollment < ApplicationRecord
  validates :code, presence: true,
                   uniqueness: true

  belongs_to :student
  belongs_to :course
end
