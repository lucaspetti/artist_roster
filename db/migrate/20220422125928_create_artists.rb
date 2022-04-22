class CreateArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.integer :followers
      t.integer :popularity
      t.string :spotify_id

      t.timestamps
    end
  end
end
