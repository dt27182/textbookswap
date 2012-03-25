class CreateBooksCourses < ActiveRecord::Migration
  def up
  	create_table :books_courses, :id => false do |t|
			t.integer :book_id
			t.integer :course_id
		end
  end

  def down
  		drop_table :books_courses
  end
end

