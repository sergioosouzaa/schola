# frozen_string_literal: true

class Student < ApplicationRecord
  validates :name, presence: true
  validates :born_on, presence: true,
                      comparison: { less_than: proc { Time.zone.today } }

  has_many :enrollments, dependent: :destroy
  has_many :grades, through: :enrollments
  has_many :courses, through: :enrollments

  scope :with_enrollment_details_from_year, lambda { |year|
    joins("LEFT JOIN (#{Enrollment.by_course.by_year(year).to_sql}) temp on temp.student_id = students.id")
      .order('students.name ASC')
      .select('students.id AS id, temp.enrollment_code AS enrollment_code, students.name AS student_name, temp.course AS course_name')
  }
end
