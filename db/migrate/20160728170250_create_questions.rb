class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :poll_id, null: false
      t.text :text, null: false

      t.timestamps null: false
    end
    add_index :questions, :poll_id
  end
end
