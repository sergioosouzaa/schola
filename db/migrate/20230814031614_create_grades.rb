# frozen_string_literal: true

class CreateGrades < ActiveRecord::Migration[7.0]
  def change
    create_table :grades do |t|
      t.float :value, null: false
      t.string :enrollment_code, null: false, index: true
      t.references :exam, null: false, foreign_key: true

      t.timestamps
    end
    add_foreign_key :grades, :enrollments, column: :enrollment_code, primary_key: :code
  end
end
