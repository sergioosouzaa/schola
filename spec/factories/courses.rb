# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    year { rand(2001..Time.zone.today.year) }
    sequence :name, (5..9).map { |n| "#{n}th grade" }.cycle
    starts_on { Time.zone.parse("#{year}-02-06").at_beginning_of_week }
    ends_on { Time.zone.parse("#{year}-11-25").at_end_of_week }
  end
end
