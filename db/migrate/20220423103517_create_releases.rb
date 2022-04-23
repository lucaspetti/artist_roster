class CreateReleases < ActiveRecord::Migration[6.0]
  def change
    create_table :releases do |t|
      t.datetime :released_at
      t.references :artist, null: false, foreign_key: true
      t.string :image_url
      t.string :spotify_id
      t.string :release_type, null: false
      t.string :title, null: false
      t.text :notes

      t.timestamps
    end
  end
end
