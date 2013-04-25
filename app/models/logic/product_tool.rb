# encoding: utf-8
module Logic
  class ProductTool
    class << self
      def batch_listed params, status
        ids = Cat::Tool.ids_to_arr(params['ids'])
        if ids
          Product.update_all("status = #{status}", "id IN (#{ids.join(',')})")
          {status: 1, message: I18n.t('admin.mess.update_successfully')}
        else
          {status: 0, message: 'please select an item'}
        end
      end

      def batch_destroy params
        ids = Cat::Tool.ids_to_arr(params['ids'])
        if ids
          Product.destroy_all('id IN (' + ids.join(',') + ')')
          {status: 1, message: I18n.t('admin.mess.destroy_successfully')}
        else
          {staus: 0, message: 'id can not be blank'}
        end
      end

      def batch_set_same_section params
        ids = Cat::Tool.ids_to_arr(params['ids'])
        if ids
          ids.each do |id|
            ids.each do |_id|
              ProductSameSection.create({product_id: id, p_id: _id}) if id != _id
            end
          end
        end
        {status: 1, message: I18n.t('admin.mess.update_successfully')}
      end

      def products_json params
        category = Category.find_by_id(params['categoryID'])

        if category.nil?
          res = {
              statusCode: 0,
              message: '非法操作'
          }
          return res
        end


        offset = params['startPos'] ? params['startPos'].to_i : 1
        offset = offset - 1
        offset = 0 if offset < 0

        limit = params['length'] ? params['length'].to_i : 10
        products = category.products.where(status: 1)

        case params['orderStyle'].to_i
          when 2
            order = 'id ASC'
          when 3
            order = 'updated_at DESC'
          when 4
            order = 'updated_at ASC'
          when 5
            order = 'serial_number DESC'
          when 6
            order = 'serial_number ASC'
          else
            order = 'id DESC'
        end

        products = products.order('is_top DESC,' + order).limit(limit).offset(offset)

        data = []
        products.each do |product|
          tmp = product.simple_json
          tmp[:someStyleProIDList] = product.same_sections
          data << tmp
        end

        {
            statusCode: 1,
            response: {
                productArray: data
            }
        }
      end

      def product_json params
        if (product = Product.find_by_id(params['id']))
          data = product.simple_json
          data[:someStyleProIDList] = product.same_sections
          res = {
              statusCode: 1,
              response: data
          }
        else
          res = {
              statusCode: 0,
              errorMessage: '单品不存在'
          }
        end
        res
      end
    end
  end
end