class CreateVerifications < ActiveRecord::Migration
  def change
    create_table :verifications do |t|
      t.integer :user_id, null: false
      t.integer :value, default: 0
      t.timestamps null: false
    end
  end
end
