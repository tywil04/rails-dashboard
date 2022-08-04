class CreateStacks < ActiveRecord::Migration[7.0]
  def change
    create_table :stacks do |t|
      t.string :title, unique: true, null: false
      t.string :colour, default: "0xFFFFFF"
      t.integer :position

      t.timestamps
    end
  end
end
