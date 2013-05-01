Feature: Launch API

  POST device infos,
  create uniq user at first time
  response ad infos, etc.

  Scenario: create a new device successfully
    Given there is a category
      | name         | status |
      | foo category | 1      |
    And there is a new product
      | name            | status |
      | foo new product | 1      |
    And there is a skin
      | title    | status |
      | foo skin | 1      |
    And there is home ad
      | status |
      | 1      |
    When I send a POST request to "/v1/launch.json" with following data
      | userID              |
      | foo-example-user-id |
    Then the device with uid "foo-example-user-id" should be created
    And I should receive the JSON response data
    """
      {
        "statusCode": 1,
        "response": {
          "skinModelID": "#{@skin.id}",
          "skinModelUpdateTime": "#{@skin.updated_at.to_s}",
          "skinModel":{
            "skinModelID":"#{@skin.id}",
            "createTime":"#{@skin.created_at.to_s}",
            "updateTime":"#{@skin.updated_at.to_s}",
            "skinCategoryProBgURL":"", "skinLCategoryProBgURL":"", "skinSuitsListBgURL":"", "skinLSuitsListBgURL":"", "skinSuitBgURL":"", "skinLSuitBgURL":"", "skinProListBgURL":"", "skinLProListBgURL":"", "skinProBgURL":"", "skinLProBgURL":"", "skinOtherBgURL":"", "skinLOtherBgURL":"", "skinToolShowHideBtnURL":"", "skinLToolShowHideBtnURL":"", "skinToolHomeBtnURL":"", "skinLToolHomeBtnURL":"", "skinSearchBtnURL":"", "skinLSearchBtnURL":"", "skinCloseBtnURL":"", "skinLCloseBtnURL":"", "skinCloseToHomeBtnURL":"", "skinLCloseToHomeBtnURL":"", "skinLeftArrowBtnURL":"", "skinLLeftArrowBtnURL":"", "skinRightArrowBtnURL":"", "skinLRightArrowBtnURL":"", "skinToolBgImageURL":"", "skinLToolBgImageURL":"", "skinBrandInfoBtnURL":"", "skinLBrandInfoBtnURL":"", "skinProShowBtnURL":"", "skinLProShowBtnURL":"", "skinCityWeekBtnURL":"", "skinLCityWeekBtnURL":"", "skinLastestSeeBtnURL":"", "skinLLastestSeeBtnURL":"", "skinShopInfoBtnURL":"", "skinLShopInfoBtnURL":"", "skinBackBtnURL":"", "skinLBackBtnURL":"", "skinTrendCourierBtnURL":"", "skinLTrendCourierBtnURL":"", "skinProToSuitBtnURL":"", "skinLProToSuitBtnURL":"", "skinProEvaluateBtnURL":"", "skinLProEvaluateBtnURL":"", "skinProTextBgURL":"", "skinLProTextBgURL":""
          },
          "appHomeAdsArray":[
            {
              "appHomeAdsImageURL":"",
              "updateTime": "#{@ad.updated_at.to_s}"
            }
          ],
          "lastestProductList": [
            {
              "lastestProductID": "#{@new_product.id}",
              "lastestProductName":"foo new product",
              "lastestProductURL": ""
            }
          ],
          "categoryProductList": [
            {
              "categoryProductID": "#{@category.id}",
              "categoryProductName": "foo category",
              "categoryProductURL":""
            }
          ]
        }
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
