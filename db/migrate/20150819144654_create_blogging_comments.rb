class CreateBloggingComments < ActiveRecord::Migration
  def change
    create_table :blogging_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :blog_id
      t.integer :parent

      t.timestamps null: false
    end
  end
end
