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

    end
  end
end