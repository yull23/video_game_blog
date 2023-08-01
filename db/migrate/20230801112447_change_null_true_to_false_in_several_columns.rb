class ChangeNullTrueToFalseInSeveralColumns < ActiveRecord::Migration[7.0]
  def change
    change_column_null :games, :name, false
    change_column_null :companies, :name, false
    change_column_null :platforms, :name, false
    change_column_null :genres, :name, false
    change_column_null :users, :username, false
    change_column_null :users, :email, false
    change_column_null :games, :category, false
    change_column_null :platforms, :category, false
    change_column_null :critics, :title, false
    change_column_null :critics, :body, false
    change_column_null :involed_companies, :developer, false
    change_column_null :involed_companies, :publisher, false
  end
end
