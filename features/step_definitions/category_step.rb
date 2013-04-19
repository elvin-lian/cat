Given(/^there is a category$/) do |table|
  @category = Category.create!(table.hashes[0])
end
