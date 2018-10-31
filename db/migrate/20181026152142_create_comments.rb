class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :descrition
      t.integer :user_id
      t.integer :topic_id
      t.timestamps
    end
  end
end
