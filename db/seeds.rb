# frozen_string_literal: true

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

subjects = Subject.all

## Create teachers
21.times do
  Teacher.create(name: FFaker::Name.first_name)
end

## Create courses (and students/enrollments for the first year and for every 5 grade)
(2012..2023).each do |year|
  (5..9).each do |grade|
    course = Course.create(year:, name: "#{grade}-#{year}", starts_on: Date.new(year, 1, 1),
                           ends_on: Date.new(year, 12, 31))
    if year == 2012 || grade == 5
      rand(20..40).times do
        student = Student.create(name: FFaker::Name.name, born_on: Date.new(year - 5 - grade, rand(1..12), rand(1..28)))
        Enrollment.create(student:, course:, code: Faker::Internet.unique.uuid.delete('-')[0, 10])
      end
    else
      last_course = Course.find_by(year: year - 1, name: "#{grade - 1}-#{year - 1}")
      last_course_enrollments = Enrollment.where(course: last_course)
      last_course_enrollments.each do |enrollment|
        continue = rand(1..10)
        if continue > 2
          Enrollment.create(course:, student: enrollment.student, code: Faker::Internet.unique.uuid.delete('-')[0, 10])
        else
          new_student = Student.create(name: FFaker::Name.name, born_on: Date.new(year - 5 - grade, rand(1..12), rand(1..28)))
          Enrollment.create(course:, student: new_student, code: Faker::Internet.unique.uuid.delete('-')[0, 10])
        end
      end
    end
  end
end

teachers = Teacher.all
## Create allocations
course_id = 0
Course.find_each do |course|
  subject_num = 0
  subjects.each do |subject|
    teacher = teachers[subject_num + (course_id % 3)]
    TeacherAssignment.create(teacher:, subject:, course:)
    subject_num += 1
    exam_num = course.year == 2023 ? 4 : 8
    exam_num.times do
      Exam.create(course:, subject:, realized_on: Date.new(course.year, rand(2..11), rand(1..28)))
    end
  end
  course_id += 1
end

Exam.find_each do |exam|
  exam.enrollments.each do |enrollment|
    Grade.create(value: rand(0.0..10.0).round(1), enrollment:, exam:)
  end
end
