# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_14_044714) do
  create_table "courses", force: :cascade do |t|
    t.integer "year", null: false
    t.string "name", null: false
    t.date "starts_on", null: false
    t.date "ends_on", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["year", "name"], name: "index_courses_on_year_and_name", unique: true
  end

  create_table "enrollments", primary_key: "code", id: :string, force: :cascade do |t|
    t.integer "student_id", null: false
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_enrollments_on_course_id"
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "exams", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "subject_id", null: false
    t.date "realized_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_exams_on_course_id"
    t.index ["subject_id"], name: "index_exams_on_subject_id"
  end

  create_table "grades", force: :cascade do |t|
    t.float "value", null: false
    t.string "enrollment_code", null: false
    t.integer "exam_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enrollment_code"], name: "index_grades_on_enrollment_code"
    t.index ["exam_id"], name: "index_grades_on_exam_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name", null: false
    t.date "born_on", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_subjects_on_name", unique: true
  end

  create_table "teacher_assignments", force: :cascade do |t|
    t.integer "teacher_id", null: false
    t.integer "subject_id", null: false
    t.integer "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_teacher_assignments_on_course_id"
    t.index ["subject_id"], name: "index_teacher_assignments_on_subject_id"
    t.index ["teacher_id"], name: "index_teacher_assignments_on_teacher_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "students"
  add_foreign_key "exams", "courses"
  add_foreign_key "exams", "subjects"
  add_foreign_key "grades", "enrollments", column: "enrollment_code", primary_key: "code"
  add_foreign_key "grades", "exams"
  add_foreign_key "teacher_assignments", "courses"
  add_foreign_key "teacher_assignments", "subjects"
  add_foreign_key "teacher_assignments", "teachers"
end
