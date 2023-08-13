# frozen_string_literal: true

FactoryBot.define do
  factory :teacher do
    name { FFaker::Name.name }
  end
end
