class CreateWeightEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :weight_entries do |t|
      t.integer :value
      t.date :day

      t.timestamps
    end

    add_index :weight_entries, :day
  end
end
