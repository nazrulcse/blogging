class AddIsBlogAdminFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_blog_admin, :boolean, :default => false
  end
end
