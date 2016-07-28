class RemoveQuestionId < ActiveRecord::Migration
  def change
    remove_column :responses, :question_id
  end
end
