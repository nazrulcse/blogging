class AddImageToBloggingBlogs < ActiveRecord::Migration
  def change
    add_column :blogging_blogs, :image, :string
  end
end
