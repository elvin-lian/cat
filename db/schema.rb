# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130510123922) do

  create_table "admins", :force => true do |t|
    t.string   "name",                :default => "", :null => false
    t.string   "email",               :default => "", :null => false
    t.string   "encrypted_password",  :default => "", :null => false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "role"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["name"], :name => "index_admins_on_name", :unique => true

  create_table "ads", :force => true do |t|
    t.string   "pic"
    t.boolean  "status",     :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "ads", ["status"], :name => "index_ads_on_status"

  create_table "brands", :force => true do |t|
    t.string   "pdf"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "pic"
    t.integer  "rank",                         :default => 0
    t.boolean  "status",                       :default => true
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.integer  "parent_category", :limit => 1, :default => 0
  end

  add_index "categories", ["rank"], :name => "index_categories_on_rank"
  add_index "categories", ["status"], :name => "index_categories_on_status"

  create_table "categories_products", :force => true do |t|
    t.integer "category_id"
    t.integer "product_id"
  end

  add_index "categories_products", ["category_id"], :name => "index_categories_products_on_category_id"
  add_index "categories_products", ["product_id"], :name => "index_categories_products_on_product_id"

  create_table "city_weeklies", :force => true do |t|
    t.string   "title",       :limit => 100
    t.string   "pic",         :limit => 100
    t.text     "description"
    t.boolean  "status",                     :default => false
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  create_table "devices", :force => true do |t|
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "devices", ["uid"], :name => "index_devices_on_uid", :length => {"uid"=>16}

  create_table "latest_see_pictures", :force => true do |t|
    t.integer  "latest_see_id"
    t.string   "title"
    t.string   "pic"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "rank",          :default => 20
  end

  add_index "latest_see_pictures", ["latest_see_id"], :name => "index_latest_see_pictures_on_latest_see_id"
  add_index "latest_see_pictures", ["rank"], :name => "index_latest_see_pictures_on_rank"

  create_table "latest_sees", :force => true do |t|
    t.string   "title"
    t.boolean  "status",     :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "new_products", :force => true do |t|
    t.string   "name"
    t.string   "pic"
    t.integer  "rank",       :default => 0
    t.boolean  "status",     :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "new_products", ["rank"], :name => "index_new_products_on_rank"
  add_index "new_products", ["status"], :name => "index_new_products_on_status"

  create_table "new_products_suits", :force => true do |t|
    t.integer "suit_id"
    t.integer "new_product_id"
  end

  add_index "new_products_suits", ["new_product_id"], :name => "index_new_products_suits_on_new_product_id"
  add_index "new_products_suits", ["suit_id"], :name => "index_new_products_suits_on_suit_id"

  create_table "product_comments", :force => true do |t|
    t.integer  "product_id"
    t.integer  "device_id"
    t.integer  "price_score",  :limit => 1
    t.integer  "design_score", :limit => 1
    t.integer  "fabric_score", :limit => 1
    t.boolean  "status",                    :default => true
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "product_comments", ["product_id"], :name => "index_product_comments_on_product_id"
  add_index "product_comments", ["status"], :name => "index_product_comments_on_status"

  create_table "product_pictures", :force => true do |t|
    t.string   "pic"
    t.integer  "product_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "rank",       :default => 10
  end

  add_index "product_pictures", ["rank"], :name => "index_product_pictures_on_rank"

  create_table "product_same_sections", :force => true do |t|
    t.integer "product_id"
    t.integer "p_id"
  end

  add_index "product_same_sections", ["p_id"], :name => "index_product_same_sections_on_p_id"
  add_index "product_same_sections", ["product_id"], :name => "index_product_same_sections_on_product_id"

  create_table "products", :force => true do |t|
    t.string   "serial_number",      :limit => 100
    t.string   "title",              :limit => 100
    t.text     "description"
    t.boolean  "status",                            :default => true
    t.integer  "trend_courier_id"
    t.datetime "created_at",                                          :null => false
    t.datetime "updated_at",                                          :null => false
    t.string   "sub_title"
    t.boolean  "is_top"
    t.string   "price"
    t.text     "design_inspiration"
    t.string   "color_pic"
    t.text     "summary"
    t.integer  "suit_category",      :limit => 1
    t.string   "time_for_sale"
  end

  add_index "products", ["is_top"], :name => "index_products_on_is_top"
  add_index "products", ["status"], :name => "index_products_on_status"

  create_table "products_suits", :force => true do |t|
    t.integer "product_id"
    t.integer "suit_id"
  end

  add_index "products_suits", ["product_id"], :name => "index_products_suits_on_product_id"
  add_index "products_suits", ["suit_id"], :name => "index_products_suits_on_suit_id"

  create_table "shop_infos", :force => true do |t|
    t.string   "pic"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "skins", :force => true do |t|
    t.string   "category_pro_bg"
    t.string   "l_category_pro_bg"
    t.string   "suits_list_bg"
    t.string   "l_suits_list_bg"
    t.string   "suit_bg"
    t.string   "l_suit_bg"
    t.string   "pro_list_bg"
    t.string   "l_pro_list_bg"
    t.string   "pro_bg"
    t.string   "l_pro_bg"
    t.string   "other_bg"
    t.string   "l_other_bg"
    t.string   "tool_show_hide_btn"
    t.string   "l_tool_show_hide_btn"
    t.string   "tool_home_btn"
    t.string   "l_tool_home_btn"
    t.string   "search_btn"
    t.string   "l_search_btn"
    t.string   "close_btn"
    t.string   "l_close_btn"
    t.string   "close_to_home_btn"
    t.string   "l_close_to_home_btn"
    t.string   "left_arrow_btn"
    t.string   "l_left_arrow_btn"
    t.string   "right_arrow_btn"
    t.string   "l_right_arrow_btn"
    t.string   "tool_bg_image"
    t.string   "l_tool_bg_image"
    t.string   "brand_info_btn"
    t.string   "l_brand_info_btn"
    t.string   "pro_show_btn"
    t.string   "l_pro_show_btn"
    t.string   "city_week_btn"
    t.string   "l_city_week_btn"
    t.string   "lastest_see_btn"
    t.string   "l_lastest_see_btn"
    t.string   "shop_info_btn"
    t.string   "l_shop_info_btn"
    t.string   "back_btn"
    t.string   "l_back_btn"
    t.string   "trend_courier_btn"
    t.string   "l_trend_courier_btn"
    t.string   "pro_to_suit_btn"
    t.string   "l_pro_to_suit_btn"
    t.string   "pro_evaluate_btn"
    t.string   "l_pro_evaluate_btn"
    t.string   "pro_text_bg"
    t.string   "l_pro_text_bg"
    t.string   "title"
    t.boolean  "status",               :default => false
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  create_table "suits", :force => true do |t|
    t.string   "title",         :limit => 64
    t.string   "serial_number", :limit => 100
    t.string   "pic"
    t.boolean  "status",                       :default => true
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "suits", ["status"], :name => "index_suits_on_status"

  create_table "trend_couriers", :force => true do |t|
    t.string   "title",      :limit => 64
    t.string   "pic"
    t.boolean  "status"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "trend_couriers", ["status"], :name => "index_trend_couriers_on_status"

end
