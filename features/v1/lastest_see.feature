Feature: Latest See API

  Background: prepare data
    Given there is a latest see
      | title | status |
      | foo   | 1      |

  Scenario: get city weekly successfully by new product id
    When I send a GET request to "/v1/lastest_see.json" with following data
      | userID              |
      | foo-example-user-id |
    Then I should receive the JSON response data
    """
      {
        "statusCode": 1,
        "response": {
          "lastestSeeImageList": []
        }
      }
    """
