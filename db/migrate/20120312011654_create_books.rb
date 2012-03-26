class CreateBooks < ActiveRecord::Migration
  def up
  	create_table :books do |t|
			t.string :title
			t.string :author
			t.string :edition
			t.integer :isbn
			t.integer :suggested_price
			t.timestamps
		end
  end

  def down
  	drop_table :books
  end
end
