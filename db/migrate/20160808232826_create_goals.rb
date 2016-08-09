class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.text :description
      t.text :visibility
      t.text :completed
      t.integer :user_id, null: false
      t.timestamps null: false
    end


  end
end
