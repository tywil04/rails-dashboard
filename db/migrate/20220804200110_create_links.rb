class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.belongs_to :stack, null: false, foreign_key: true
      t.string :displayname
      t.string :url
      t.integer :position

      t.timestamps
    end
  end
end
