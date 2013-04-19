Given(/^there is a brand$/) do |table|
  @brand = Brand.create!(table.hashes[0])
end
