# frozen_string_literal: true

class CreateTeacherAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :teacher_assignments do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
