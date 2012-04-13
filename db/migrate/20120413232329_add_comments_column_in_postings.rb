class AddCommentsColumnInPostings < ActiveRecord::Migration
  def up
  	add_column :postings, :comments, :string
  end

  def down
  	remove_column :postings, :comments
  end
end
