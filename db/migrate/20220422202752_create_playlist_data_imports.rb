class CreatePlaylistDataImports < ActiveRecord::Migration[6.0]
  def change
    create_table :playlist_data_imports do |t|
      t.string :file
      t.references :artist, null: false, foreign_key: true
      t.integer :month
      t.integer :year
      t.datetime :ran_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
