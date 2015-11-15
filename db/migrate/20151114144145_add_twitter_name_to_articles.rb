class AddTwitterNameToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :twitter_screen_name, :string
  end
end
