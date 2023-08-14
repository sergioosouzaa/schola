# frozen_string_literal: true

class CreateExams < ActiveRecord::Migration[7.0]
  def change
    create_table :exams do |t|
      t.references :course, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true
      t.date :realized_on

      t.timestamps
    end
  end
end
