# frozen_string_literal: true

class Grade < ApplicationRecord
  validates :value, presence: true,
                    numericality: { in: 0.0..10.0 }

  belongs_to :exam
  belongs_to :enrollment, foreign_key: :enrollment_code, inverse_of: :grades

  scope :average_grades_from_year, -> (year, id) {
    joins(enrollment: { course: { exams: :subject } })
    .where(enrollments: { student_id: id })
    .where(courses: { year: })
    .group('subjects.name', 'courses.name', 'courses.year', 'enrollments.code')
    .select('subjects.name AS subject',
            'courses.name AS course',
            'enrollments.code AS code',
            'AVG(grades.value) AS avg_grade')
    .order('subjects.name')
  }
end
