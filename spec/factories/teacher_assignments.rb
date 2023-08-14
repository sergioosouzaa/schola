# frozen_string_literal: true

FactoryBot.define do
  factory :teacher_assignment do
    teacher
    subject
    course
  end
end
