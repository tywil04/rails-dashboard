class RemoveColourFromStacks < ActiveRecord::Migration[7.0]
  def change
    remove_column :stacks, :colour
  end
end
