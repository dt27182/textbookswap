class AddMisc < ActiveRecord::Migration
  VALS = [{:key => "semester", :value => "spring"},
          {:key => "year", :value => "2012"},
          {:key => "expiration_time", :value => "90"}]
  def up
    VALS.each do |val|
      Misc.create!(val)
    end
  end

  def down
    VALS.each do |val|
      Misc.find_by_key_and_value(val[:key], val[:value]).destroy
    end
  end
end
