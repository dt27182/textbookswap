class CreatePostings < ActiveRecord::Migration
  def up
  	create_table :postings do |t|
			t.string :seller_email
			t.string :seller_name
			t.integer :price
			t.integer :location
			t.datetime :date_posted
			t.string :condition
			t.timestamps
			t.integer :book_id
		end
  end

  def down
  	drop_table :postings
  end
end
