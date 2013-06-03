module Logic
  class SuitTool
    class << self
      def search params
        limit = params['length'] ? params['length'].to_i : 10
        offset = params['startPos'] ? params['startPos'].to_i - 1 : 0
        offset = 0 if offset < 0

        product_ids = []
        if !params['categoryName'].blank?
          if (category = Category.where(:name => params['categoryName']).last)
            product_ids = category.products.where(status: 1).order('id desc').limit(4000).pluck(:id)
          end
          unless params['colorName'].blank? or product_ids.blank?
            product_ids = Product.where(id: product_ids, color_name: params['colorName']).order('id desc').limit(2000).pluck(:id)
          end
        elsif params['categoryName'].blank? and !params['colorName'].blank?
          product_ids = Product.where(status: 1, color_name: params['colorName']).order('id desc').limit(2000).pluck(:id)
        end

        suit_arr = []
        unless product_ids.empty?
          #case params[:orderStyle].to_i
          #  when 2
          #    order = 'suits.id ASC'
          #  when 3
          #    order = 'suits.updated_at DESC'
          #  when 4
          #    order = 'suits.updated_at ASC'
          #  when 5
          #    order = 'suits.serial_number DESC'
          #  when 6
          #    order = 'suits.serial_number ASC'
          #  else
          #    order = 'suits.id DESC'
          #end
          order = 'suits.rank DESC, suits.id DESC'
          Suit.includes(:products).where('suits.status' => 1, 'products.id' => product_ids).order(order).limit(limit).offset(offset).each do |suit|
            suit_arr << suit.simple_json
          end
        end

        {
            statusCode: 1,
            response: {
                suitArray: suit_arr
            }
        }
      end
    end
  end
end