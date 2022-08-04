class CreateStacks < ActiveRecord::Migration[7.0]
  def change
    create_table :stacks do |t|
      t.string :title
      t.string :colour
      t.integer :position

      t.timestamps
    end
  end
end
