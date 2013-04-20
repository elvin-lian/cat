Given(/^there is a product$/) do |table|
  @product = Product.create!(table.hashes[0])
end

Given(/^this product belongs to this category$/) do
  @category.products << @product
end


Given(/^this product belongs to this suit$/) do
  @suit.products << @product
end
