# frozen_string_literal: true

class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :name, null: false
      t.date :born_on, null: false

      t.timestamps
    end
  end
end
