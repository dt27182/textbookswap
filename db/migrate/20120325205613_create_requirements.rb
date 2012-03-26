class CreateRequirements < ActiveRecord::Migration
  def up
  	create_table :requirements do |t|
  		t.references :course
  		t.references :book
  		t.boolean :is_required
  		t.timestamps
  	end
  end

  def down
  	drop_table :requirements
  end
end
