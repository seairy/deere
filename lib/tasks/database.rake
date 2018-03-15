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
        project = Project.create!(code: 'Okra').tap do |project|
          brand = project.models.create!(code: 'brand', localized_name: '品牌', name: 'Brand').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.regular_properties.tap do |regular_properties_association|
              regular_properties_association.create!(code: 'name', localized_name: '名称', name: 'Name', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_uniqueness_validation!
                property.create_length_validation!(maximum: 50)
              end
            end
          end
          province = project.models.create!(code: 'province', localized_name: '省市', name: 'Province').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.regular_properties.tap do |regular_properties_association|
              regular_properties_association.create!(code: 'name', localized_name: '名称', name: 'Name', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_uniqueness_validation!
                property.create_length_validation!(maximum: 50)
              end
            end
          end
          city = project.models.create!(code: 'city', localized_name: '城市', name: 'City').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.regular_properties.tap do |regular_properties_association|
              regular_properties_association.create!(code: 'name', localized_name: '名称', name: 'Name', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 50)
              end
            end
          end
          Cascade.create!(source: province, destination: city, type: :has_many, optional: false, action_when_owner_destroyed: :restrict_with_exception, action_when_child_destroyed: :nothing)
          region = project.models.create!(code: 'region', localized_name: '地区', name: 'Region').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.regular_properties.tap do |regular_properties_association|
              regular_properties_association.create!(code: 'name', localized_name: '名称', name: 'Name', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 50)
              end
            end
          end
          Cascade.create!(source: city, destination: region, type: :has_many, optional: false, action_when_owner_destroyed: :restrict_with_exception, action_when_child_destroyed: :nothing).tap do |cascade|
            cascade.redundancies.create!(model: province)
          end
          station = project.models.create!(code: 'station', localized_name: '工作站', name: 'Station').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.create_authenticatable!(account_name: 'domain')
            model.regular_properties.tap do |regular_properties_association|
              regular_properties_association.create!(code: 'name', localized_name: '名称', name: 'Name', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_uniqueness_validation!
                property.create_length_validation!(maximum: 100)
              end
              model.file_properties.create!(code: 'image', localized_name: '图片', name: 'Image', common_validation_attributes: { empty_tolerance: :blank, on_actions: :all }).tap do |property|
                property.image_uploaders.create!(quality: 80, resize_method: :fill, width: 600, height: 300)
              end
              regular_properties_association.create!(code: 'address', localized_name: '地址', name: 'Address', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 200)
              end
              regular_properties_association.create!(code: 'latitude', localized_name: '纬度', name: 'Lat', type: :decimal, precision: 8, scale: 6, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_numericality_validation(minimum: -90, includes_minimum: false, maximum: 90, includes_maximum: false, only_integer: false)
              end
              regular_properties_association.create!(code: 'longitude', localized_name: '经度', name: 'Long', type: :decimal, precision: 9, scale: 6, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_numericality_validation(minimum: -180, includes_minimum: false, maximum: 180, includes_maximum: false, only_integer: false)
              end
              regular_properties_association.create!(code: 'delivery_area', localized_name: '配送范围', name: 'Delivery Area', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 200)
              end
            end
          end
          Cascade.create!(source: region, destination: station, type: :has_many, optional: false, action_when_owner_destroyed: :restrict_with_exception, action_when_child_destroyed: :nothing)
          platform = project.models.create!(code: 'platform', localized_name: '平台', name: 'Platform').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.regular_properties.tap do |regular_properties_association|
              model.enumeration_properties.create!(code: 'type', localized_name: '类型', name: 'Type', common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.elements.create!([
                  { code: 'eleme', localized_name: '饿了么', name: 'Eleme' },
                  { code: 'meituan', localized_name: '美团外卖', name: 'Meituan' },
                  { code: 'baidu', localized_name: '百度外卖', name: 'Baidu' }
                ])
              end
              regular_properties_association.create!(code: 'account', localized_name: '账号', name: 'Account', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_uniqueness_validation!
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(code: 'password', localized_name: '密码', name: 'Password', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(code: 'mobile_number', localized_name: '手机号', name: 'Mobile Number', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(minimum: 11, maximum: 11)
                property.create_numericality_validation(only_integer: true)
              end
              regular_properties_association.create!(code: 'url', localized_name: '网址', name: 'URL', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_uniqueness_validation!
                property.create_length_validation!(maximum: 200)
                property.create_format_validation!(regular_expression: '\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\Z')
              end
            end
          end
          Cascade.create!(source: brand, destination: platform, type: :has_many, optional: false, action_when_owner_destroyed: :restrict_with_exception, action_when_child_destroyed: :nothing)
          Cascade.create!(source: station, destination: platform, type: :has_many, optional: false, action_when_owner_destroyed: :restrict_with_exception, action_when_child_destroyed: :nothing)
          platform_order = project.models.create!(code: 'platform_order', localized_name: '平台订单', name: 'Platform Order').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.regular_properties.tap do |regular_properties_association|
              regular_properties_association.create!(code: 'number', localized_name: '单号', name: 'Number', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_uniqueness_validation!
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(code: 'daily_number', localized_name: '日单号', name: 'Daily Number', type: :integer, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_numericality_validation(minimum: 0, includes_minimum: false, only_integer: true)
              end
              model.enumeration_properties.create!(code: 'payment_method', localized_name: '付款方式', name: 'Payment Method', common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.elements.create!([
                  { code: 'online', localized_name: '在线支付', name: 'Online' },
                  { code: 'offline', localized_name: '货到付款', name: 'Offline' }
                ])
              end
              regular_properties_association.create!(code: 'expect_time_of_arrival', localized_name: '期望送达', name: 'ETA', type: :datetime, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all })
              regular_properties_association.create!(code: 'recipient_name', localized_name: '收货人姓名', name: 'Recipient Name', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 20)
              end
              model.enumeration_properties.create!(code: 'recipient_gender', localized_name: '收货人性别', name: 'Recipient Gender', common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.elements.create!([
                  { code: 'male', localized_name: '先生', name: 'Male' },
                  { code: 'female', localized_name: '女士', name: 'Female' },
                  { code: 'unknown', localized_name: '未知', name: 'Unknown' }
                ])
              end
              regular_properties_association.create!(code: 'recipient_mobile_number', localized_name: '收货人手机号', name: 'Recipient Mobile Number', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 20)
              end
              regular_properties_association.create!(code: 'recipient_address', localized_name: '收货人地址', name: 'Recipient Address', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 200)
              end
              regular_properties_association.create!(code: 'recipient_address_longitude', localized_name: '收货人地址经度', name: 'Recipient Address Long', type: :decimal, precision: 8, scale: 6, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all }).tap do |property|
                property.create_numericality_validation(minimum: -90, includes_minimum: false, maximum: 90, includes_maximum: false, only_integer: false)
              end
              regular_properties_association.create!(code: 'recipient_address_latitude', localized_name: '收货人地址纬度', name: 'Recipient Address Lat', type: :decimal, precision: 9, scale: 6, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all }).tap do |property|
                property.create_numericality_validation(minimum: -180, includes_minimum: false, maximum: 180, includes_maximum: false, only_integer: false)
              end
              regular_properties_association.create!(code: 'delivery_method_code', localized_name: '配送方式编码', name: 'Delivery Method Code', type: :string, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all }).tap do |property|
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(code: 'deliverer_name', localized_name: '配送员姓名', name: 'Deliverer Name', type: :string, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all }).tap do |property|
                property.create_length_validation!(maximum: 20)
              end
              regular_properties_association.create!(code: 'deliverer_mobile_number', localized_name: '配送员手机号', name: 'Deliverer Mobile Number', type: :string, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all }).tap do |property|
                property.create_length_validation!(minimum: 11, maximum: 11)
                property.create_numericality_validation(only_integer: true)
              end
              regular_properties_association.create!(code: 'invoice_title', localized_name: '发票抬头', name: 'Invoice Title', type: :string, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all }).tap do |property|
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(code: 'unified_social_credit_code', localized_name: '税号', name: 'USCC', type: :string, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all }).tap do |property|
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(code: 'new_user', localized_name: '新用户', name: 'New?', type: :boolean, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all })
              regular_properties_association.create!(code: 'followed_user', localized_name: '收藏用户', name: 'Followed?', type: :boolean, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all })
              regular_properties_association.create!(code: 'product_original_price', localized_name: '商品价格', name: 'Product Original Price', type: :decimal, precision: 10, scale: 2, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_numericality_validation!(only_integer: false)
              end
              regular_properties_association.create!(code: 'packing_charge', localized_name: '餐盒费', name: 'Packing Charge', type: :decimal, precision: 6, scale: 2, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_numericality_validation!(only_integer: false)
              end
              regular_properties_association.create!(code: 'delivery_fee', localized_name: '配送费', name: 'Delivery Fee', type: :decimal, precision: 6, scale: 2, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_numericality_validation!(only_integer: false)
              end
              regular_properties_association.create!(code: 'total_original_price', localized_name: '原价', name: 'Total Original Price', type: :decimal, precision: 8, scale: 2, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_numericality_validation!(only_integer: false)
              end
              regular_properties_association.create!(code: 'service_fee', localized_name: '服务费', name: 'Service Fee', type: :decimal, precision: 6, scale: 2, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_numericality_validation!(only_integer: false)
              end
              regular_properties_association.create!(code: 'revenue', localized_name: '结算额', name: 'Revenue', type: :decimal, precision: 6, scale: 2, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_numericality_validation!(only_integer: false)
              end
              regular_properties_association.create!(code: 'paid_at', localized_name: '付款时间', name: 'Paid Time', type: :datetime, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
              end
              regular_properties_association.create!(code: 'remarks', localized_name: '备注', name: 'Remarks', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_length_validation!(maximum: 200)
              end
            end
          end
          Cascade.create!(source: platform, destination: platform_order, type: :has_many, optional: false, action_when_owner_destroyed: :restrict_with_exception, action_when_child_destroyed: :nothing).tap do |cascade|
            cascade.redundancies.create!(model: brand)
            cascade.redundancies.create!(model: station)
          end
          platform_review = project.models.create!(code: 'platform_review', localized_name: '平台评价', name: 'Platform Review').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.regular_properties.tap do |regular_properties_association|
              regular_properties_association.create!(code: 'number', localized_name: '评价号', name: 'Number', type: :string, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(code: 'order_number', localized_name: '订单号', name: 'Order Number', type: :string, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all }).tap do |property|
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(code: 'service_rating', localized_name: '商家评分', name: 'Service Rating', type: :integer, common_validation_attributes: { empty_tolerance: :not_allowed, on_actions: :all }).tap do |property|
                property.create_presence_validation!
                property.create_numericality_validation!(minimum: 1, includes_minimum: true, maximum: 5, includes_maximum: true, only_integer: true)
              end
              regular_properties_association.create!(code: 'content', localized_name: '内容', name: 'Content', type: :string, common_validation_attributes: { empty_tolerance: :blank, on_actions: :all }).tap do |property|
                property.create_length_validation!(maximum: 200)
              end
            end
          end
          Cascade.create!(source: platform, destination: platform_review, type: :has_many, optional: false, action_when_owner_destroyed: :restrict_with_exception, action_when_child_destroyed: :nothing).tap do |cascade|
            cascade.redundancies.create!(model: brand)
            cascade.redundancies.create!(model: station)
          end
          project.namespaces.create!(name: 'admin', module: 'administration', path: 'admin').tap do |namespace|
            namespace.listing_logics.create!(model: Model.find_by(code: 'brand'), type: :regular)
            namespace.detailing_logics.create!(model: Model.find_by(code: 'brand'), type: :regular)
            namespace.individual_creation_logics.create!(model: Model.find_by(code: 'brand'), type: :regular)
            namespace.individual_updation_logics.create!(model: Model.find_by(code: 'brand'), type: :regular)
          end
        end
      end
    end unless Rails.env.production?
    p "finished in #{bench.real.round(2)} second(s), at #{Time.now.strftime('%Y-%m-%d %H:%M')}"
  end
end
