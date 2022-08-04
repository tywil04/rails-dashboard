class RemovePositionFromLinks < ActiveRecord::Migration[7.0]
  def change
    remove_column :links, :position
  end
end
