class AddNullFalseToVoteColumns < ActiveRecord::Migration
  def change
    change_column :votes, :voteable_id, :integer, null: false
    change_column :votes, :voteable_type, :string, null: false
    change_column :votes, :user_id, :integer, null: false
  end
end
