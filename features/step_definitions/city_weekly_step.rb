Given(/^there is a weekly$/) do |table|
  @city_weekly = CityWeekly.create!(table.hashes[0])
end
