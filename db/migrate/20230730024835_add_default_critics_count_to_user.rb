class AddDefaultCriticsCountToUser < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :critics_count, from:nil, to: 0
  end
end
