Given(/^there is a product$/) do |table|
  @product = Product.create!(table.hashes[0])
end

Given(/^there is another product$/) do |table|
  @another_product = Product.create!(table.hashes[0])
end

Given(/^this product belongs to this category$/) do
  @category.products << @product
end


Given(/^this product belongs to this suit$/) do
  @suit.products << @product
end

Given(/^these two products are the same section$/) do
  ProductSameSection.create!(product_id: @product.id, p_id: @another_product.id)
  ProductSameSection.create!(product_id: @another_product.id, p_id: @product.id)
end

