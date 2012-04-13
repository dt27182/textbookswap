class DeleteDatePostedColumnInPostings < ActiveRecord::Migration
  def up
  	remove_column :postings, :date_posted
  end

  def down
  end
end
