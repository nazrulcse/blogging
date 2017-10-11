class AddFieldsToBlog < ActiveRecord::Migration
  def change
    add_column :blogging_blogs, :status, :boolean, default: false
    add_column :blogging_blogs, :published_at, :datetime
  end
end
