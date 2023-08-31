# frozen_string_literal: true

class Student < ApplicationRecord
  validates :name, presence: true
  validates :born_on, presence: true,
                      comparison: { less_than: proc { Time.zone.today } }

  has_many :enrollments, dependent: :destroy
  has_many :grades, through: :enrollments
  has_many :courses, through: :enrollments

  scope :index_from_year, -> (year) {
    joins("LEFT JOIN (SELECT e.code, c.name, c.year, e.student_id
      FROM enrollments e
     JOIN courses c ON c.id = e.course_id AND c.year = #{year}) AS active_enrollments ON active_enrollments.student_id = students.id")
    .order("students.name, active_enrollments.year")
    .select("students.id AS id, active_enrollments.code AS enrollment_code, students.name AS student_name, active_enrollments.name AS course_name, active_enrollments.year")
  }
end
