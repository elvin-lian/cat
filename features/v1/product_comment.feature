Feature: product comment API


  Scenario: create a new product comment successfully
    Given there is a product
      | serial_number | status |
      | xxx-xxx       | 1      |
    When I send a POST request to "/v1/product_comments.json" with following data
      | userID              | productID      | evaluatePriceScore | evaluateDesignScore | evaluateFabricScore |
      | foo-example-user-id | #{@product.id} | 1                  | 2                   | 5                   |
    Then the comment of this product shout be created
    And I should receive the JSON response data
    """
      {
        "statusCode": 1,
        "response": { }
      }
    """
