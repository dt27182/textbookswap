class CreateMisc < ActiveRecord::Migration
  def up
    create_table 'miscs' do |t|
      t.string 'key'
      t.string 'value'
    end
  end

  def down
    drop_table 'miscs'
  end
end
