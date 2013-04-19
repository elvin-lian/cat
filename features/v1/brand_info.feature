Feature: Brand Info API

  Get Brand info

  Scenario: get Brand info successfully
    Given there is a brand
      | pdf |
      |     |
    When I send a GET request to "/v1/brand_info.json" with following data
      | userID              |
      | foo-example-user-id |
    Then I should receive the JSON response data
    """
      {
        "statusCode": 1,
        "response": {
          "pdfURL": "",
          "updateTime": "#{@brand.updated_at.to_s}"
        }
      }
    """