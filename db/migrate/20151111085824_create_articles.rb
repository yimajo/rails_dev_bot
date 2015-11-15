class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text :url,            null: false
      t.string :title,        null: false
      t.string :author_name,  null: false
      t.integer :kind
      t.string :qiita_uuid

      t.timestamps null: false

      t.index [:url], :unique => true
    end
  end
end
