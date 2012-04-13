class DeleteReservedColumnInBooks < ActiveRecord::Migration
  def up
  	remove_column :books, :reserved
  end

  def down
  	add_column :books, :reserved, :boolean, :default => false
  end
end
