# frozen_string_literal: true

class Teacher < ApplicationRecord
  validates :name, presence: true
end
