class AddReservedColumnInPostings < ActiveRecord::Migration
  def up
  	add_column :postings, :reserved, :boolean, :default => false
  end

  def down
  	remove_column :postings, :reserved
  end
end
