class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name, null: false
      t.integer :album_id, null: false
      t.boolean :bonus, null: false
      t.text :lyrics
      t.timestamps null: false
    end
    add_index :tracks, :album_id
  end
end
