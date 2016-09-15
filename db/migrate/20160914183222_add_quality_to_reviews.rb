class AddQualityToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :quality, :integer
  end
end
