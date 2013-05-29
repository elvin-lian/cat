module Logic
  class NameTool
    class << self
      def as_json
        {
            statusCode: 1,
            response: {
                categoryNameList: category_names,
                colorNameList: color_names
            }
        }
      end

      def category_names
        Category.where('status = 1').order('id DESC').limit(1000).pluck(:name)
      end

      def color_names
        res = []
        Product.select('DISTINCT(color_name)').where('status = 1 AND color_name <> ""').order('id DESC').limit(5000).each do |obj|
          res << obj.color_name
        end
        res
      end

    end
  end
end
