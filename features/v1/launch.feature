Feature: Launch API

  POST device infos,
  create uniq user at first time
  response ad infos, etc.

  Scenario: create a new device successfully
    When I send a POST request to "/v1/launch.json" with following data
      | userID              |
      | foo-example-user-id |
    Then the device with uid "foo-example-user-id" should be created
    And I should receive the JSON response data
    """
      {
        "statusCode": 1,
        "response": {}
      }
    """

  Scenario: fail to create a new device without userID
    When I send a POST request to "/v1/launch.json" with following data
      | userid              |
      | foo-example-user-id |
    Then the device with uid "foo-example-user-id" should not be created
    And I should receive the JSON response data
    """
      {
        "statusCode": 0,
        "errorMessage": "非法操作！"
      }
    """
