class CreatePlaylists < ActiveRecord::Migration[6.0]
  def change
    create_table :playlists do |t|
      t.string :name, null: false
      t.string :author, null: false
      t.string :mood
      t.string :genre
      t.text :description
      t.string :image

      t.timestamps
    end
  end
end
