# frozen_string_literal: true

NUM_EXAMS_NORMAL_YEAR = 8
NUM_EXAMS_FINAL_YEAR = 4
FIRST_YEAR = 2012
LAST_YEAR = 2023
FIRST_SCHOOL_GRADE = 5
LAST_SCHOOL_GRADE = 9
NUMBER_OF_SUBJECTS = 7
NUMBER_OF_TEACHERS = 21
MINIMUM_NUMBER_OF_STUDENTS_ON_CLASS = 20
MAXIMUM_NUMBER_OF_STUDENTS_ON_CLASS = 20
TEACHER_SUBJECT_RATIO = NUMBER_OF_TEACHERS / NUMBER_OF_SUBJECTS

def create_courses
  (FIRST_YEAR..LAST_YEAR).each do |year|
    (FIRST_SCHOOL_GRADE..LAST_SCHOOL_GRADE).each do |grade|
      course = FactoryBot.create(:course, year:, name: "#{grade}-#{year}")
      if year == FIRST_YEAR || grade == FIRST_SCHOOL_GRADE
        create_new_class(course:)
      else
        create_students(year:, course:, grade:)
      end
    end
  end
end

def create_students(year:, grade:, course:)
  last_course = Course.find_by(year: year - 1, name: "#{grade - 1}-#{year - 1}")

  last_course.enrollments.each do |enrollment|
    if rand(1..10) > 2
      FactoryBot.create(:enrollment, course:, student: enrollment.student)
    else
      FactoryBot.create(:enrollment, course:, student: FactoryBot.create(:student))
    end
  end
end

def create_teacher_assignments
  assignments = []
  teachers = Teacher.all
  Course.find_each.with_index do |course, course_iteration|
    Subject.find_each.with_index do |subject, index|
      teacher = teachers[(index * TEACHER_SUBJECT_RATIO) + (course_iteration % TEACHER_SUBJECT_RATIO)]
      assignments << { teacher_id: teacher.id, subject_id: subject.id, course_id: course.id }
    end
  end
  TeacherAssignment.insert_all(assignments)
end

def create_exams
  exams = []
  Course.find_each do |course|
    Subject.find_each do |subject|
      exam_num = course.year == LAST_YEAR ? NUM_EXAMS_FINAL_YEAR : NUM_EXAMS_NORMAL_YEAR
      exam_num.times do
        exams << { course_id: course.id, subject_id: subject.id }
      end
    end
  end
  Exam.insert_all(exams)
end

def create_all_grades
  grades = []
  Exam.includes(course: :enrollments).find_each do |exam|
    exam.course.enrollments.each do |enrollment|
      grades << { value: rand(0.0..10.0).round(1), enrollment_code: enrollment.code, exam_id: exam.id }
    end
  end
  Grade.insert_all(grades)
end

def create_new_class(course:)
  rand(MINIMUM_NUMBER_OF_STUDENTS_ON_CLASS..MAXIMUM_NUMBER_OF_STUDENTS_ON_CLASS).times do
    student = FactoryBot.create(:student)
    FactoryBot.create(:enrollment, student:, course:)
  end
end

start = Time.zone.now

puts 'Creating Subjects...'
FactoryBot.create_list(:subject, NUMBER_OF_SUBJECTS)
puts 'Done!'

puts 'Creating Teachers...'
FactoryBot.create_list(:teacher, NUMBER_OF_TEACHERS)
puts 'Done!'

puts 'Creating courses and students'
create_courses
puts 'Done!'

puts 'Creating teachers assignments...'
create_teacher_assignments
puts 'Done'

puts 'Creating exams...'
create_exams
puts 'Done!'

puts 'Creating grades...'
create_all_grades
puts 'Done!'

puts "Seeds created in #{format('%.2f', Time.zone.now - start)} seconds!"
