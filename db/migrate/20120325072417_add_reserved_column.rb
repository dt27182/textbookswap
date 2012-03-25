class AddReservedColumn < ActiveRecord::Migration
  def up
  	add_column :books, :reserved, :boolean, :default => 0
  end

  def down
  	remove_column :books, :reserved
  end
end
