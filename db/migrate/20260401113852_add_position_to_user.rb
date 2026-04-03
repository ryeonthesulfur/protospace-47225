class AddPositionToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :position, :text, null: false
  end
end
