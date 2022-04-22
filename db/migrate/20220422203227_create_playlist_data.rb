class CreatePlaylistData < ActiveRecord::Migration[6.0]
  def change
    create_table :playlist_data do |t|
      t.integer :month, null: false
      t.integer :year, null: false
      t.references :playlist, null: false, foreign_key: true
      t.references :artist, null: false, foreign_key: true
      t.references :playlist_data_import, null: false, foreign_key: true
      t.integer :streams
      t.integer :listeners
      t.integer :followers

      t.timestamps
    end
  end
end
