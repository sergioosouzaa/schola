# frozen_string_literal: true

class TeacherAssignment < ApplicationRecord
  belongs_to :teacher
  belongs_to :subject
  belongs_to :course
end
