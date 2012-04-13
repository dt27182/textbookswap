class DeleteDatePostedColumnInPostings < ActiveRecord::Migration
  def up
  	remove_column :postings, :date_posted
  end

  def down
  	add_column :postings, :date_posted, :datetime
  end
end
