class CreateJoinTableGamePlatform < ActiveRecord::Migration[7.0]
  def change
    # rails g migration CreateJoinTableGamePlatform game platform
    create_join_table :games, :platforms do |t|
      # t.index [:game_id, :platform_id]
      # t.index [:platform_id, :game_id]
    end
  end
end
