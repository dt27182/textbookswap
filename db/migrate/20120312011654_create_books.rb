class CreateBooks < ActiveRecord::Migration
  def up
  	create_table :books do |t|
			t.string :title
			t.string :author
			t.string :edition
			t.integer :isbn
			t.integer :suggested_price
			t.string :comments
			t.string :condition
			t.timestamps
			t.integer :course_id
		end
  end

  def down
  	drop_table :books
  end
end
