# frozen_string_literal: true

class Enrollment < ApplicationRecord
  validates :code, presence: true,
                   uniqueness: true

  belongs_to :student
  belongs_to :course
  has_many :grades, dependent: :destroy, foreign_key: :enrollment_code, inverse_of: :enrollment

  scope :by_course, lambda {
    joins(:course)
      .select('courses.name as course', 'enrollments.code as enrollment_code', 'enrollments.student_id as student_id')
  }

  scope :by_year, lambda { |year|
    joins(:course)
      .where(courses: { year: })
  }
end
