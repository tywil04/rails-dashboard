class CreateShortcuts < ActiveRecord::Migration[7.0]
  def change
    create_table :shortcuts do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :rid, unique: true
      t.string :url
      t.boolean :private, default: true

      t.timestamps
    end
  end
end
