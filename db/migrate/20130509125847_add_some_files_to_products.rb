class AddSomeFilesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :summary, :text
    add_column :products, :suit_category, :integer, :limit => 1, :default =>0
    add_column :products, :time_for_sale, :string
  end
end
