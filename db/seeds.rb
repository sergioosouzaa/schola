# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

Enrollment.destroy_all
Grade.destroy_all
Exam.destroy_all
TeacherAssignment.destroy_all
Course.destroy_all
Subject.destroy_all
Teacher.destroy_all
Student.destroy_all

## Create Subjects
subjects = %w[Matemática Português História Geografia Física Química Inglês]
subjects.each do |subject|
  Subject.create(name: subject)
end

## Create teachers
21.times do |_teacher_num|
  Teacher.create(name: Faker::Name.name)
end

## Create courses
(2012..2023).each do |year|
  (5..9).each do |grade|
    course = Course.create(year:, name: "0#{grade}-#{year}", starts_on: Date.new(year, 1, 1), ends_on: Date.new(year, 12, 31))
  end
end

courses = Course.all
subjects = Subject.all
teachers = Teacher.all

## Create allocations
course_id = 0
courses.each do |course|
  subject_num = 0
  subjects.each do |subject|
    teacher = teachers[subject_num + course_id % 3]
    TeacherAssignment.create(teacher:, subject:, course:)
    subject_num += 1
  end
  course_id += 1
end

## Create students and enrollments
course_year_one = Course.where(year: 2012)

course_year_one.each do |course|
  year_course = 0
  rand(20..40).times do
    student = Student.create(name: Faker::Name.unique.name, born_on: Date.new(year_course + 21, rand(1..12), rand(1..28)))
    Enrollment.create(student:, course:, code: Faker::Internet.unique.uuid.delete('-')[0, 10])
  end
  year_course += 1
end
