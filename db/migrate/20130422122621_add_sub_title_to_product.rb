class AddSubTitleToProduct < ActiveRecord::Migration
  def change
    add_column :products, :sub_title, :string
    add_column :products, :is_top, :boolean

    add_index :products, :is_top
  end

end
