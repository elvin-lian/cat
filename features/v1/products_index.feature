Feature: Product detail API


  Scenario: get a product info successfully
    Given there is a device with uid "foo-example-user-id"
    And there is a category
      | name         | status |
      | foo category | 1      |
    And there is a product
      | serial_number | status | title | description |
      | xxx-xxx       | 1      | xxx   | xxx         |
    And this product belongs to this category
    And there is another product
      | serial_number | status | title |
      | xxx-ooo       | 1      | ooo   |
    And these two products are the same section

    When I send a GET request to "/v1/products.json" with following data
      | userID              | categoryID      |
      | foo-example-user-id | #{@category.id} |
    Then I should receive the JSON response data
    """
      {
        "statusCode": 1,
        "response": {
          "productArray": [
            {
              "proID": "#{@product.id}",
              "proSerialNumber": "xxx-xxx",
              "proTitle": "xxx",
              "proSubTitle": "",
              "proRank": 0,
              "proPrice": "",
              "createTime": "#{@product.created_at.to_s}",
              "updateTime": "#{@product.updated_at.to_s}",
              "proExplainText": "xxx",
              "proDesignInspiration": "",
              "proColorImageURL": "",
              "proColorName": "",
              "proTrendCourierID": "",
              "proTrendCourierUrl": "",
              "proImageURLArray": [],
              "proSimpleIntroduce": "",
              "timeForSale": "",
              "proSuitCategoryID": "",
              "proSuitCategoryName": "",
              "someStyleProIDList":[
                {
                  "proID": "#{@another_product.id}",
                  "proSerialNumber": "xxx-ooo",
                  "proTitle": "ooo",
                  "proSubTitle": "",
                  "proPrice": "",
                  "proRank": 0,
                  "createTime": "#{@another_product.created_at.to_s}",
                  "updateTime": "#{@another_product.updated_at.to_s}",
                  "proExplainText": "",
                  "proDesignInspiration": "",
                  "proColorImageURL": "",
                  "proColorName": "",
                  "proTrendCourierID": "",
                  "proTrendCourierUrl": "",
                  "proSimpleIntroduce": "",
                  "timeForSale": "",
                  "proSuitCategoryID": "",
                  "proSuitCategoryName": "",
                  "proImageURLArray": []
                }
              ]
            }
          ]
        }
      }
    """