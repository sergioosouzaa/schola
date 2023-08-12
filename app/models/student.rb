# frozen_string_literal: true

class Student < ApplicationRecord
  validates :name, presence: true
  validates :born_on, presence: true,
                      comparison: { less_than: proc { Time.zone.today } }
end
