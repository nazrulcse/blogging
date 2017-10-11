class CreateBloggingWidgets < ActiveRecord::Migration
  def change
    create_table :blogging_widgets do |t|
      t.string :name
      t.text :content

      t.timestamps null: false
    end
  end
end
