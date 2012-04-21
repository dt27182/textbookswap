class ChangeDataTypeInIsbnColumnInBooks < ActiveRecord::Migration
  def up
  	change_table :books do |t|
  		t.change :isbn, :string
  	end
  end

  def down
		change_table :books do |t|
  		t.change :isbn, :integer
  	end
  end
end
