class AddOccupationToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :occupation, :text, null: false
  end
end
