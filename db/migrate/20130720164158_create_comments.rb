class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.string :by
      t.integer :micropost_id

      t.timestamps
    end
    add_index :comments, [:micropost_id, :created_at]
  end
end
