class AddUserToWeightEntry < ActiveRecord::Migration[5.0]
  def change
    add_reference :weight_entries, :user, index: true
  end
end
