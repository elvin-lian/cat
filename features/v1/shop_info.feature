Feature: Shop Info API

  Get Shop info

  Scenario: get nil shop info
    Given there is a device with uid "foo-example-user-id"

    When I send a GET request to "/v1/shop_info.json" with following data
      | userID              |
      | foo-example-user-id |
    Then I should receive the JSON response data
    """
      {
        "statusCode": 0,
        "errorMessage": "店铺信息不存在!"
      }
    """