Given(/^there is a new product$/) do |table|
  @new_product = NewProduct.create!(table.hashes[0])
end
