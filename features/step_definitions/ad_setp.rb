Given(/^there is home ad$/) do |table|
  @ad = Ad.create!(table.hashes[0])
end