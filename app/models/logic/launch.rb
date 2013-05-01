# encoding: utf-8
module Logic
  class Launch

    class << self
      def init params

        error_res = {
            statusCode: 0,
            errorMessage: '非法操作！'
        }
        return error_res unless params['userID']

        device = Device.find_or_create_by_uid(params['userID'])
        return error_res if device.nil?

        response = {}
        response = response.merge(skin_json)
        response = response.merge(home_ad_json)
        response = response.merge(new_product_json)
        response = response.merge(category_json)

        {
            statusCode: 1,
            response: response
        }
      end

      private

      def skin_json
        skin = Skin.where('status = 1').last
        if skin.nil?
          {skinModelID: '', skinModelUpdateTime: ''}
        else
          {skinModelID: skin.id.to_s, skinModelUpdateTime: skin.updated_at.to_s, skinModel: skin.simple_json}
        end
      end

      def home_ad_json
        ads = Ad.where('status = 1').order('id DESC').limit(100)
        res = []
        unless ads.empty?
          ads.each { |ad| res << ad.simple_json }
        end
        {appHomeAdsArray: res}
      end

      def new_product_json
        res = []
        new_products = NewProduct.where('status = 1').order('rank DESC, id DESC').limit(100)
        unless new_products.empty?
          new_products.each { |product| res << product.simple_json }
        end
        {lastestProductList: res}
      end

      def category_json
        res = []
        categories = Category.where('status = 1').order('rank DESC, id DESC').limit(100)
        unless categories.empty?
          categories.each { |cat| res << cat.simple_json }
        end
        {categoryProductList: res}
      end

    end
  end
end
