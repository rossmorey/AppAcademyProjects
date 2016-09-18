class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :user_id, null: false
      t.integer :answer_choice_id, null: false
      t.integer :question_id, null: false

      t.timestamps null: false
    end
    add_index :responses, :user_id
    add_index :responses, :answer_choice_id
    add_index :responses, :question_id
  end
end
