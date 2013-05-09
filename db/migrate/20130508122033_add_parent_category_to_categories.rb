class AddParentCategoryToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :parent_category, :integer, :default => 0, :limit => 1
  end
end
