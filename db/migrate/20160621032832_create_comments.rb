class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :user_id, null: false
      t.integer :fpa_id, null: false
    end
  end
end
