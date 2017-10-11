class CreateBloggingContact < ActiveRecord::Migration
  def change
    create_table :blogging_contact do |t|
      t.string :name
      t.string :email
      t.text :message

      t.timestamps null: false
    end
  end
end
