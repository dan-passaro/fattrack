class ChangeValueFromIntegerToDecimal < ActiveRecord::Migration[5.0]
  def up
    change_column :weight_entries, :value, :decimal, precision: 4, scale: 1
  end
  
  def down
     change_column :weight_entries, :value, :integer
  end
end
