# frozen_string_literal: true

FactoryBot.define do
  factory :enrollment do
    code { SecureRandom.uuid }
    student
    course
  end
end
