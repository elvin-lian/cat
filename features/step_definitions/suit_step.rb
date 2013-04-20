Given(/^there is a suit$/) do |table|
  @suit = Suit.create!(table.hashes[0])
end

Given(/^this new product belongs to the suit$/) do
  @suit.new_products << @new_product
end
