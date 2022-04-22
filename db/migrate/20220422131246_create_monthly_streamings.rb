class CreateMonthlyStreamings < ActiveRecord::Migration[6.0]
  def change
    create_table :monthly_streamings do |t|
      t.integer :month
      t.integer :year
      t.integer :streams, default: 0
      t.integer :listeners, default: 0
      t.integer :followers, default: 0
      t.references :month_streaming_import, null: false, foreign_key: true

      t.timestamps
    end
  end
end
