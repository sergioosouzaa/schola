# frozen_string_literal: true

FactoryBot.define do
  factory :grade do
    value { rand(0.0..10.0) }
    enrollment
    exam
  end
end
