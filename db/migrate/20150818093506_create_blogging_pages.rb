class CreateBloggingPages < ActiveRecord::Migration
  def change
    create_table :blogging_pages do |t|
      t.string :title
      t.string :slug
      t.string :keyword
      t.string :menu
      t.text :content

      t.timestamps null: false
    end
  end
end
