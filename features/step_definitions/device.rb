Given(/^there is a device with uid "(.*?)"$/) do |uid|
  Device.create!(uid: uid)
end



Then(/^the device with uid "(.*?)" should be created$/) do |uid|
  Device.find_by_uid(uid).should_not be_nil
end

Then(/^the device with uid "(.*?)" should not be created$/) do |uid|
  Device.find_by_uid(uid).should be_nil
end

