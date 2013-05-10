class RemoveColorFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :color_name
    remove_column :products, :color_rgb
  end

  def down
    add_column :products, :color_rgb, :string
    add_column :products, :color_name, :string
  end
end
