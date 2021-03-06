# encoding: utf-8
module AdminBreadcrumbHelper

  def ad_breadcrumb ad
    output_breadcrumb [['所有广告', admin_ads_path, cc: [:read, Ad]],
                       [ad.id, admin_ad_path(ad), cc: [:read, Ad]]]
  end

  def category_breadcrumb category
    output_breadcrumb [['所有品类', admin_categories_path, cc: [:read, Category]],
                       [category.name, admin_category_path(category), cc: [:read, Category]]]
  end

  def city_weekly_breadcrumb city_weekly
    output_breadcrumb [['都市周报', admin_city_weeklies_path, cc: [:read, CityWeekly]],
                       [city_weekly.title, admin_city_weekly_path(city_weekly), cc: [:read, CityWeekly]]]
  end

  def latest_see_breadcrumb see
    output_breadcrumb [['所有宾视', admin_latest_sees_path, cc: [:read, LatestSee]],
                       [see.title, admin_latest_see_path(see), cc: [:read, LatestSee]]]
  end

  def latest_see_picture_breadcrumb see, picture
    output_breadcrumb [["宾视: #{see.title}", admin_latest_see_path(see), cc: [:read, LatestSee]],
                       ['所有图片', admin_latest_see_pictures_path(see), cc: [:read, LatestSeePicture]]]
  end

  def new_product_breadcrumb product
    output_breadcrumb [['所有新品', admin_new_products_path, cc: [:read, NewProduct]],
                       [product.name, admin_new_product_path(product), cc: [:read, NewProduct]]]
  end

  def product_breadcrumb product
    output_breadcrumb [['所有单品', admin_products_path, cc: [:read, Product]],
                       [product.title, admin_product_path(product), cc: [:read, Product]]]
  end

  def product_comment_breadcrumb product, comment
    output_breadcrumb [['所有评论', admin_product_comments_path(product), cc: [:read, ProductComment]],
                       [comment.id, nil]]
  end

  def product_same_section_breadcrumb product
    output_breadcrumb [['所有单品', admin_products_path, cc: [:read, Product]],
                       [product.title, admin_product_path(product), cc: [:read, Product]],
                       ['同款单品', admin_product_same_sections_path(@product), cc: [:read, ProductSameSection]],
                      ]
  end

  def suit_breadcrumb suit
    output_breadcrumb [['所有套装', admin_suits_path, cc: [:read, Suit]],
                       [suit.serial_number, admin_suit_path(suit), cc: [:read, Suit]]]
  end

  def skin_breadcrumb skin
    output_breadcrumb [['所有皮肤', admin_skins_path, cc: [:read, Skin]],
                       [skin.id, admin_skin_path(skin), cc: [:read, Skin]]]
  end

  def trend_courier_breadcrumb trend_courier
    output_breadcrumb [['所有潮流速递', admin_trend_couriers_path, cc: [:read, TrendCourier]],
                       [trend_courier.id, admin_trend_courier_path(trend_courier), cc: [:read, TrendCourier]]]
  end


  private

  def output_breadcrumb breadcrumbs
    html = ''
    breadcrumbs.insert(0, ['首页', admin_dashboard_index_path])

    breads = []
    breadcrumbs.each do |bread|
      next if bread.empty? or bread.first.nil?
      if bread.third
        breads << cc_link_to(bread.first, bread.second, cc: [bread.third[:cc].first, bread.third[:cc].second, display: false])
      elsif bread.second
        breads << link_to(bread.first, bread.second)
      elsif bread.first
        breads << bread.first
      end
    end

    html << '<ul class="breadcrumb"><li>'
    html << breads.join('<span class="divider">/</span></li><li>')
    html << '</li></ul>'
    html.html_safe
  end

end