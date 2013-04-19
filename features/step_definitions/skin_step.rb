Given(/^there is a skin$/) do |table|
  @skin = Skin.create!(table.hashes[0])
end