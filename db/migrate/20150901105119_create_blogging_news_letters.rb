class CreateBloggingNewsLetters < ActiveRecord::Migration
  def change
    create_table :blogging_news_letters do |t|
      t.string :email

      t.timestamps null: false
    end
  end
end
