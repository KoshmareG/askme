class CreateQuestionHashTags < ActiveRecord::Migration[7.0]
  def change
    create_table :question_hash_tags do |t|
      t.references :question, null: false, foreign_key: true
      t.references :hash_tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
