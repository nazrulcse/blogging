class AddAttrTypeFieldToWidgets < ActiveRecord::Migration
  def change
    add_column :blogging_widgets, :attr_type, :string, :default => 'html'
  end
end
