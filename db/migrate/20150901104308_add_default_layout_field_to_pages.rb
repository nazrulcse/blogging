class AddDefaultLayoutFieldToPages < ActiveRecord::Migration
  def change
    add_column :blogging_pages, :default_layout, :boolean, :default => false
  end
end
