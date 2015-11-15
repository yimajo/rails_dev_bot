class RenameColumnToArticles < ActiveRecord::Migration
  def change
    rename_column :articles, :qiita_uuid, :qiita_id
  end
end
