class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :content
      t.float :longitude
      t.float :latitude
      t.boolean :is_map
      t.references :user_id, foreign_key: true

      t.timestamps
    end
      add_index :posts, [:user_id, :created_at]
  end
end
