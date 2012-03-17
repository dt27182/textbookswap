class CreateCourses < ActiveRecord::Migration
  def up
    create_table :courses do |t|
      t.string :number
      t.string :department_short
      t.string :department_long
      t.string :teacher
      t.string :section
      t.integer :year
      t.string :term
      t.timestamps
    end
  end

  def down
    drop_table :courses
  end
end
