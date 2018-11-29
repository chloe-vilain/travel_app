class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.string :image
      t.text :caption
      t.float :longitude
      t.float :latitude
      t.boolean :is_map
      t.references :user_id, foreign_key: true

      t.timestamps
    end
    add_index :pictures, [:user_id, :created_at]
  end
end
