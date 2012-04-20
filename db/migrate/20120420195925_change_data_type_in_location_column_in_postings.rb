class ChangeDataTypeInLocationColumnInPostings < ActiveRecord::Migration
  def up
  	change_table :postings do |t|
  		t.change :location, :string
  	end
  end

  def down
		change_table :postings do |t|
  		t.change :location, :integer
  	end
  end
end
