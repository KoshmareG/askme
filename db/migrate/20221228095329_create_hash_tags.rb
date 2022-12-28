class CreateHashTags < ActiveRecord::Migration[7.0]
  def change
    create_table :hash_tags do |t|
      t.string :text, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
