Feature: Suit list API

  get suit list

  Background: prepare data
    Given there is a suit
      | serial_number | status | title |
      | 11-11-xx      | 1      | foo   |
    And there is a new product
      | name            | status |
      | foo new product | 1      |
    And this new product belongs to the suit
    And there is a category
      | name         | status |
      | foo category | 1      |
    And there is a product
      | serial_number | status | title |
      | xxx-xxx       | 1      | xxx   |
    And this product belongs to this category
    And this product belongs to this suit

  Scenario: get suits successfully by new product id
    When I send a GET request to "/v1/suits.json" with following data
      | userID              | lastestProductID   | orderStyle | startPos | length |
      | foo-example-user-id | #{@new_product.id} | 2          | 1        | 10     |
    Then I should receive the JSON response data
    """
      {
        "statusCode": 1,
        "response": {
          "suitArray":[
            {
              "suitID": "#{@suit.id}",
              "suitTitle": "foo",
              "suitSerialNumber": "11-11-xx",
              "createTime": "#{@suit.created_at.to_s}",
              "updateTime": "#{@suit.updated_at.to_s}",
              "suitImageURL": "",
              "subProList":[
                {
                  "categoryProID": "#{@category.id}",
                  "productID": "#{@product.id}"
                }
              ]
            }
          ]
        }
      }
    """

  Scenario: get suits successfully by product id
    When I send a GET request to "/v1/suits.json" with following data
      | userID              | productID      | orderStyle | startPos | length |
      | foo-example-user-id | #{@product.id} | 2          | 1        | 10     |
    Then I should receive the JSON response data
    """
      {
        "statusCode": 1,
        "response": {
          "suitArray":[
            {
              "suitID": "#{@suit.id}",
              "suitTitle": "foo",
              "suitSerialNumber": "11-11-xx",
              "createTime": "#{@suit.created_at.to_s}",
              "updateTime": "#{@suit.updated_at.to_s}",
              "suitImageURL": "",
              "subProList":[
                {
                  "categoryProID": "#{@category.id}",
                  "productID": "#{@product.id}"
                }
              ]
            }
          ]
        }
      }
    """
