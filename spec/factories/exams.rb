# frozen_string_literal: true

FactoryBot.define do
  factory :exam do
    course
    subject
    realized_on do
      start = course&.starts_on || Time.current.at_beginning_of_year
      finish = course&.ends_on || Time.current.at_end_of_year
      rand(start..finish)
    end
  end
end
