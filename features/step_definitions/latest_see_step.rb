Given(/^there is a latest see/) do |table|
  @latest_see = LatestSee.create!(table.hashes[0])
end
