# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.integer :year, null: false
      t.string :name, null: false
      t.date :starts_on, null: false
      t.date :ends_on, null: false

      t.timestamps
    end

    add_index :courses, %i[year name], unique: true
  end
end
