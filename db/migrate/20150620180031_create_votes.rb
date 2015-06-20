class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :link_id
      t.boolean :like

      t.timestamps null: false
    end
    add_index :votes, :link_id
  end
end
