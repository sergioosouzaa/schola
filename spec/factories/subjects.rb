# frozen_string_literal: true

FactoryBot.define do
  factory :subject do
    sequence :name, %w[math portuguese english physics history geography biology].cycle
  end
end
