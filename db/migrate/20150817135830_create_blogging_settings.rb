class CreateBloggingSettings < ActiveRecord::Migration
  def change
    create_table :blogging_settings do |t|
      t.string :key
      t.string :value
      t.string :attr

      t.timestamps null: false
    end
  end
end
