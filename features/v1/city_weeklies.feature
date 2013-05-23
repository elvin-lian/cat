Feature: City Weekly API

  get city weekly list

  Background: prepare data
    Given there is a weekly
      | title | status | description |
      | foo   | 1      | foo desc    |

  Scenario: get city weekly successfully by new product id
    When I send a GET request to "/v1/city_weeklies.json" with following data
      | userID              |
      | foo-example-user-id |
    Then I should receive the JSON response data
    """
      {
        "statusCode": 1,
        "response": {
          "cityWeekContentList":[
            {
              "contentTitle": "foo",
              "contentURL": "",
              "contentText": "foo desc",
              "contentUpdateTime": "#{@city_weekly.updated_at.to_s}"
            }
          ]
        }
      }
    """
