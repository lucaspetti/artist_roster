class CreateMonthStreamingImports < ActiveRecord::Migration[6.0]
  def change
    create_table :month_streaming_imports do |t|
      t.string :file
      t.references :artist, null: false, foreign_key: true
      t.datetime :ran_at

      t.timestamps
    end
  end
end
