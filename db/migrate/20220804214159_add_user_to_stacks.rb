class AddUserToStacks < ActiveRecord::Migration[7.0]
  def change
    add_reference :stacks, :user, null: false, foreign_key: true
  end
end
