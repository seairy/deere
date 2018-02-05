namespace :database do
  desc 'Cleanup all data.'
  task reset: :environment do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
    Rake::Task['database:populate'].invoke
  end

  desc 'Populate data.'
  task populate: :environment do
    bench = Benchmark.measure do
      ActiveRecord::Base.transaction do
        project = Project.create!(name: 'Okra').tap do |project|
          brand = project.models.create!(name: 'brand', zh_name: '品牌', en_name: 'Brand').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.regular_properties.tap do |regular_properties_association|
              regular_properties_association.create!(name: 'name', zh_name: '名称', en_name: 'Name', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_uniqueness_validation!
                property.create_length_validation!(maximum: 50)
              end
            end
          end
          province = project.models.create!(name: 'province', zh_name: '省市', en_name: 'Province').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.regular_properties.tap do |regular_properties_association|
              regular_properties_association.create!(name: 'name', zh_name: '名称', en_name: 'Name', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_uniqueness_validation!
                property.create_length_validation!(maximum: 50)
              end
            end
          end
          city = project.models.create!(name: 'city', zh_name: '城市', en_name: 'City').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.regular_properties.tap do |regular_properties_association|
              regular_properties_association.create!(name: 'name', zh_name: '名称', en_name: 'Name', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 50)
              end
            end
          end
          Cascade.create!(source: province, destination: city, type: :has_many, optional: false)
          region = project.models.create!(name: 'region', zh_name: '地区', en_name: 'Region').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.regular_properties.tap do |regular_properties_association|
              regular_properties_association.create!(name: 'name', zh_name: '名称', en_name: 'Name', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 50)
              end
            end
          end
          Cascade.create!(source: city, destination: region, type: :has_many, optional: false).tap do |cascade|
            cascade.redundancies.create!(model: province)
          end
          station = project.models.create!(name: 'station', zh_name: '工作站', en_name: 'Station').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.create_authenticatable!(account_field_name: 'domain')
            model.regular_properties.tap do |regular_properties_association|
              regular_properties_association.create!(name: 'name', zh_name: '名称', en_name: 'Name', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_uniqueness_validation!
                property.create_length_validation!(maximum: 100)
              end
              model.file_properties.create!(name: 'image', zh_name: '图片', en_name: 'Image', common_validation_attributes: { empty_tolerance: :blank, on_actions: :all }).tap do |property|
                property.image_uploaders.create!(quality: 80, resize_method: :fill, width: 600, height: 300)
              end
              regular_properties_association.create!(name: 'address', zh_name: '地址', en_name: 'Address', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 200)
              end
              regular_properties_association.create!(name: 'latitude', zh_name: '纬度', en_name: 'Lat', type: :decimal, precision: 8, scale: 6, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_numericality_validation(minimum: -90, includes_minimum: false, maximum: 90, includes_maximum: false, only_integer: false)
              end
              regular_properties_association.create!(name: 'longitude', zh_name: '经度', en_name: 'Long', type: :decimal, precision: 9, scale: 6, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_numericality_validation(minimum: -180, includes_minimum: false, maximum: 180, includes_maximum: false, only_integer: false)
              end
              regular_properties_association.create!(name: 'delivery_area', zh_name: '配送范围', en_name: 'Delivery Area', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 200)
              end
            end
          end
          Cascade.create!(source: region, destination: station, type: :has_many, optional: false)
          platform = project.models.create!(name: 'platform', zh_name: '平台', en_name: 'Platform').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.regular_properties.tap do |regular_properties_association|
              model.enumeration_properties.create!(name: 'type', zh_name: '类型', en_name: 'Type', common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.elements.create!([
                  { name: 'eleme', zh_name: '饿了么', en_name: 'Eleme' },
                  { name: 'meituan', zh_name: '美团外卖', en_name: 'Meituan' },
                  { name: 'baidu', zh_name: '百度外卖', en_name: 'Baidu' }
                ])
              end
              regular_properties_association.create!(name: 'account', zh_name: '账号', en_name: 'Account', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_uniqueness_validation!
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(name: 'password', zh_name: '密码', en_name: 'Password', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(name: 'mobile_number', zh_name: '手机号', en_name: 'Mobile Number', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(minimum: 11, maximum: 11)
                property.create_numericality_validation(only_integer: true)
              end
              regular_properties_association.create!(name: 'url', zh_name: '网址', en_name: 'URL', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_uniqueness_validation!
                property.create_length_validation!(maximum: 200)
                property.create_format_validation!(regular_expression: '\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\Z')
              end
            end
          end
          Cascade.create!(source: brand, destination: platform, type: :has_many, optional: false)
          Cascade.create!(source: station, destination: platform, type: :has_many, optional: false)
          platform_order = project.models.create!(name: 'platform_order', zh_name: '平台订单', en_name: 'Platform Order').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.regular_properties.tap do |regular_properties_association|
              regular_properties_association.create!(name: 'number', zh_name: '单号', en_name: 'Number', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_uniqueness_validation!
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(name: 'daily_number', zh_name: '日单号', en_name: 'Daily Number', type: :integer, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_numericality_validation(minimum: 0, includes_minimum: false, only_integer: true)
              end
              model.enumeration_properties.create!(name: 'payment_method', zh_name: '付款方式', en_name: 'Payment Method', common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.elements.create!([
                  { name: 'online', zh_name: '在线支付', en_name: 'Online' },
                  { name: 'offline', zh_name: '货到付款', en_name: 'Offline' }
                ])
              end
              regular_properties_association.create!(name: 'expect_time_of_arrival', zh_name: '期望送达', en_name: 'ETA', type: :datetime, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all })
              regular_properties_association.create!(name: 'recipient_name', zh_name: '收货人姓名', en_name: 'Recipient Name', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 20)
              end
              model.enumeration_properties.create!(name: 'recipient_gender', zh_name: '收货人性别', en_name: 'Recipient Gender', common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.elements.create!([
                  { name: 'male', zh_name: '先生', en_name: 'Male' },
                  { name: 'female', zh_name: '女士', en_name: 'Female' },
                  { name: 'unknown', zh_name: '未知', en_name: 'Unknown' }
                ])
              end
              regular_properties_association.create!(name: 'recipient_mobile_number', zh_name: '收货人手机号', en_name: 'Recipient Mobile Number', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 20)
              end
              regular_properties_association.create!(name: 'recipient_address', zh_name: '收货人地址', en_name: 'Recipient Address', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 200)
              end
              regular_properties_association.create!(name: 'recipient_address_longitude', zh_name: '收货人地址经度', en_name: 'Recipient Address Long', type: :decimal, precision: 8, scale: 6, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all }).tap do |property|
                property.create_numericality_validation(minimum: -90, includes_minimum: false, maximum: 90, includes_maximum: false, only_integer: false)
              end
              regular_properties_association.create!(name: 'recipient_address_latitude', zh_name: '收货人地址纬度', en_name: 'Recipient Address Lat', type: :decimal, precision: 9, scale: 6, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all }).tap do |property|
                property.create_numericality_validation(minimum: -180, includes_minimum: false, maximum: 180, includes_maximum: false, only_integer: false)
              end
              regular_properties_association.create!(name: 'delivery_method_code', zh_name: '配送方式编码', en_name: 'Delivery Method Code', type: :string, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all }).tap do |property|
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(name: 'deliverer_name', zh_name: '配送员姓名', en_name: 'Deliverer Name', type: :string, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all }).tap do |property|
                property.create_length_validation!(maximum: 20)
              end
              regular_properties_association.create!(name: 'deliverer_mobile_number', zh_name: '配送员手机号', en_name: 'Deliverer Mobile Number', type: :string, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all }).tap do |property|
                property.create_length_validation!(minimum: 11, maximum: 11)
                property.create_numericality_validation(only_integer: true)
              end
              regular_properties_association.create!(name: 'invoice_title', zh_name: '发票抬头', en_name: 'Invoice Title', type: :string, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all }).tap do |property|
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(name: 'unified_social_credit_code', zh_name: '税号', en_name: 'USCC', type: :string, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all }).tap do |property|
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(name: 'new_user', zh_name: '新用户', en_name: 'New?', type: :boolean, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all })
              regular_properties_association.create!(name: 'followed_user', zh_name: '收藏用户', en_name: 'Followed?', type: :boolean, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all })
              regular_properties_association.create!(name: 'product_original_price', zh_name: '商品价格', en_name: 'Product Original Price', type: :decimal, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_numericality_validation!(only_integer: false)
              end
              regular_properties_association.create!(name: 'packing_charge', zh_name: '餐盒费', en_name: 'Packing Charge', type: :decimal, precision: 6, scale: 2, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_numericality_validation!(only_integer: false)
              end
              regular_properties_association.create!(name: 'delivery_fee', zh_name: '配送费', en_name: 'Delivery Fee', type: :decimal, precision: 6, scale: 2, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_numericality_validation!(only_integer: false)
              end
              regular_properties_association.create!(name: 'total_original_price', zh_name: '原价', en_name: 'Total Original Price', type: :decimal, precision: 8, scale: 2, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_numericality_validation!(only_integer: false)
              end
              regular_properties_association.create!(name: 'service_fee', zh_name: '服务费', en_name: 'Service Fee', type: :decimal, precision: 6, scale: 2, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_numericality_validation!(only_integer: false)
              end
              regular_properties_association.create!(name: 'revenue', zh_name: '结算额', en_name: 'Revenue', type: :decimal, precision: 6, scale: 2, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_numericality_validation!(only_integer: false)
              end
              regular_properties_association.create!(name: 'paid_at', zh_name: '付款时间', en_name: 'Paid Time', type: :datetime, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
              end
              regular_properties_association.create!(name: 'remarks', zh_name: '备注', en_name: 'Remarks', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_length_validation!(maximum: 200)
              end
            end
          end
          Cascade.create!(source: platform, destination: platform_order, type: :has_many, optional: false).tap do |cascade|
            cascade.redundancies.create!(model: brand)
            cascade.redundancies.create!(model: station)
          end
          platform_review = project.models.create!(name: 'platform_review', zh_name: '平台评价', en_name: 'Platform Review').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.regular_properties.tap do |regular_properties_association|
              regular_properties_association.create!(name: 'number', zh_name: '评价号', en_name: 'Number', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(name: 'order_number', zh_name: '订单号', en_name: 'Order Number', type: :string, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all }).tap do |property|
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(name: 'service_rating', zh_name: '商家评分', en_name: 'Service Rating', type: :integer, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_numericality_validation!(minimum: 1, includes_minimum: true, maximum: 5, includes_maximum: true, only_integer: true)
              end
              regular_properties_association.create!(name: 'content', zh_name: '内容', en_name: 'Content', type: :string, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all }).tap do |property|
                property.create_length_validation!(maximum: 200)
              end
            end
          end
          Cascade.create!(source: platform, destination: platform_review, type: :has_many, optional: false).tap do |cascade|
            cascade.redundancies.create!(model: brand)
            cascade.redundancies.create!(model: station)
          end
        end
      end
    end unless Rails.env.production?
    p "finished in #{bench.real.round(2)} second(s), at #{Time.now.strftime('%Y-%m-%d %H:%M')}"
  end
end
