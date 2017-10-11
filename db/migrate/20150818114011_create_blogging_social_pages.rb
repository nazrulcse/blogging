class CreateBloggingSocialPages < ActiveRecord::Migration
  def change
    create_table :blogging_social_pages do |t|
      t.string :icon
      t.string :name
      t.string :url

      t.timestamps null: false
    end
  end
end
