def eval_var(result)
  scans = result.scan(/\#{.+?}/)
  scans.each do |var|
    matcher = /[^\#{}]+/.match(var)
    result = result.gsub(var, eval(matcher[0]).to_s) if matcher and matcher[0]
  end
  result
end

def api_authenticate_params(params)
  params = params.as_json
  params['t'] = Time.now
  params['tkey'] = Rails.application.config.api_requirement_secret
  res = ''
  Hash[params.sort].each_value { |v| res += v.to_s }
  params['s'] = Digest::SHA1.hexdigest(res)
  params.delete('tkey')
  params
end

When /^I send a POST request to "([^"]*)" with following data(.*)$/ do |url, others, table|
  params = table.hashes[0]
  params.map { |k, v| params[k] = eval_var(v) }
  page.driver.post(eval_var(url), params)
end

When /^I send a POST api request to "([^"]*)" with following data(.*)$/ do |url, others, table|
  params = table.hashes[0]
  params.map { |k, v| params[k] = eval_var(v) }
  page.driver.post(eval_var(url), api_authenticate_params(params))
end

When /^I send a POST api request to "([^"]*)" with error signature$/ do |url, table|
  params = table.hashes[0]
  page.driver.post(eval_var(url), params.as_json)
end

When /^I send a GET request to "(.*?)" with following data(.*)$/ do |url, others, table|
  params = table.hashes[0]
  params.map { |k, v| params[k] = eval_var(v) }
  page.driver.get(eval_var(url), params)
end

When /^I send a GET request to "([^"]*)"$/ do |url|
  page.driver.get(eval_var(url))
end

Then /^I should receive the JSON response data$/ do |result|
  result = ActiveSupport::JSON.decode(eval_var(result))
  content = JSON.parse(page.source)
  content.should eq result
end

Then /^I should receive (\d+) http status$/ do |status|
  page.driver.status_code.should == status.to_i
end