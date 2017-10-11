class AddPageCssFieldToPages < ActiveRecord::Migration
  def change
    add_column :blogging_pages, :page_css, :text
  end
end
