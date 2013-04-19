class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :pdf

      t.timestamps
    end

    Brand.create(pdf: '')
  end
end
