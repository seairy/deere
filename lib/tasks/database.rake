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
        project = Project.create!(code: 'Okra', name: 'Catering Management', copyright: '© DaoCloud LLC. 2016 - 2018. All rights reserved.', primary_language: :en).tap do |project|
          administrator = project.models.create!(code: 'administrator', name: 'Administrator').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.create_authenticatable!(account_name: 'account')
            model.regular_properties.tap do |regular_properties_association|
              regular_properties_association.create!(code: 'name',
                name: 'Name',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all 
                }
              ).tap do |property|
                property.create_presence_validation!
                property.create_uniqueness_validation!
                property.create_length_validation!(maximum: 100)
              end
            end
          end
          brand = project.models.create!(code: 'brand', name: 'Brand').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.regular_properties.tap do |regular_properties_association|
              regular_properties_association.create!(code: 'name',
                name: 'Name',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all 
                }
              ).tap do |property|
                property.create_presence_validation!
                property.create_uniqueness_validation!
                property.create_length_validation!(maximum: 50)
              end
            end
          end
          province = project.models.create!(code: 'province', name: 'Province').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.regular_properties.tap do |regular_properties_association|
              regular_properties_association.create!(code: 'name',
                name: 'Name',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_presence_validation!
                property.create_uniqueness_validation!
                property.create_length_validation!(maximum: 50)
              end
            end
          end
          city = project.models.create!(code: 'city', name: 'City').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.regular_properties.tap do |regular_properties_association|
              regular_properties_association.create!(code: 'name',
                name: 'Name',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 50)
              end
            end
          end
          Cascade.create!(source: province, destination: city, type: :has_many, optional: false, action_when_owner_destroyed: :restrict_with_exception, action_when_child_destroyed: :nothing)
          region = project.models.create!(code: 'region', name: 'Region').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.regular_properties.tap do |regular_properties_association|
              regular_properties_association.create!(code: 'name',
                name: 'Name',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 50)
              end
            end
          end
          Cascade.create!(source: city, destination: region, type: :has_many, optional: false, action_when_owner_destroyed: :restrict_with_exception, action_when_child_destroyed: :nothing).tap do |cascade|
            cascade.redundancies.create!(model: province)
          end
          station = project.models.create!(code: 'station', name: 'Station').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.create_authenticatable!(account_name: 'domain')
            model.create_state_machine!.tap do |state_machine|
              buliding_state = state_machine.states.create!(code: 'building',
                name: 'Buliding')
              normal_state = state_machine.states.create!(code: 'normal',
                name: 'Normal')
              closed_state = state_machine.states.create!(code: 'closed',
                name: 'Closed')
              state_machine.events.create!(destination: normal_state, code: 'complete').tap do |state_machine_event|
                state_machine_event.sources.create!(state_machine_state: buliding_state)
              end
              state_machine.events.create!(destination: closed_state, code: 'close').tap do |state_machine_event|
                state_machine_event.sources.create!(state_machine_state: normal_state)
              end
            end
            model.regular_properties.tap do |regular_properties_association|
              regular_properties_association.create!(code: 'name',
                name: 'Name',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_presence_validation!
                property.create_uniqueness_validation!
                property.create_length_validation!(maximum: 100)
              end
              model.file_properties.create!(code: 'image',
                name: 'Image',
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :blank,
                  on_actions: :all
                }
              ).tap do |property|
                property.image_uploaders.create!(quality: 80, resize_method: :fill, width: 600, height: 300)
              end
              regular_properties_association.create!(code: 'address',
                name: 'Address',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 200)
              end
              regular_properties_association.create!(code: 'latitude',
                name: 'Lat',
                type: :decimal,
                precision: 8,
                scale: 6,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_presence_validation!
                property.create_numericality_validation(minimum: -90, includes_minimum: false, maximum: 90, includes_maximum: false, only_integer: false)
              end
              regular_properties_association.create!(code: 'longitude',
                name: 'Long',
                type: :decimal,
                precision: 9,
                scale: 6,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_presence_validation!
                property.create_numericality_validation(minimum: -180, includes_minimum: false, maximum: 180, includes_maximum: false, only_integer: false)
              end
              regular_properties_association.create!(code: 'delivery_area',
                name: 'Delivery Area',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 200)
              end
            end
          end
          Cascade.create!(source: region, destination: station, type: :has_many, optional: false, action_when_owner_destroyed: :restrict_with_exception, action_when_child_destroyed: :nothing)
          platform = project.models.create!(code: 'platform', name: 'Platform').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.create_state_machine!.tap do |state_machine|
              state_machine.states.create!(code: 'closed',
                name: 'Closed')
              state_machine.states.create!(code: 'open',
                name: 'Open')
            end
            model.regular_properties.tap do |regular_properties_association|
              model.enumeration_properties.create!(code: 'type',
                name: 'Type',
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_presence_validation!
                property.elements.create!([
                  { code: 'eleme', name: 'Eleme' },
                  { code: 'meituan', name: 'Meituan' },
                  { code: 'baidu', name: 'Baidu' }
                ])
              end
              regular_properties_association.create!(code: 'account',
                name: 'Account',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_presence_validation!
                property.create_uniqueness_validation!
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(code: 'password',
                name: 'Password',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(code: 'mobile_number',
                name: 'Mobile Number',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(minimum: 11, maximum: 11)
                property.create_numericality_validation(only_integer: true)
              end
              regular_properties_association.create!(code: 'url',
                name: 'URL',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_presence_validation!
                property.create_uniqueness_validation!
                property.create_length_validation!(maximum: 200)
                property.create_format_validation!(regular_expression: '\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\Z')
              end
            end
          end
          Cascade.create!(source: brand, destination: platform, type: :has_many, optional: false, action_when_owner_destroyed: :restrict_with_exception, action_when_child_destroyed: :nothing)
          Cascade.create!(source: station, destination: platform, type: :has_many, optional: false, action_when_owner_destroyed: :restrict_with_exception, action_when_child_destroyed: :nothing)
          platform_order = project.models.create!(code: 'platform_order', name: 'Platform Order').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.regular_properties.tap do |regular_properties_association|
              regular_properties_association.create!(code: 'number',
                name: 'Number',
                type: :string,
                sculpture: true,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_presence_validation!
                property.create_uniqueness_validation!
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(code: 'daily_number',
                name: 'Daily Number',
                type: :integer,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_presence_validation!
                property.create_numericality_validation(minimum: 0, includes_minimum: false, only_integer: true)
              end
              model.enumeration_properties.create!(code: 'payment_method',
                name: 'Payment Method',
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_presence_validation!
                property.elements.create!([
                  { code: 'online', name: 'Online' },
                  { code: 'offline', name: 'Offline' }
                ])
              end
              regular_properties_association.create!(code: 'expect_time_of_arrival',
                name: 'ETA',
                type: :datetime,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :blank,
                  on_actions: :all
                }
              )
              regular_properties_association.create!(code: 'recipient_name',
                name: 'Recipient Name',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 20)
              end
              model.enumeration_properties.create!(code: 'recipient_gender',
                name: 'Recipient Gender',
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_presence_validation!
                property.elements.create!([
                  { code: 'male', name: 'Male' },
                  { code: 'female', name: 'Female' },
                  { code: 'unknown', name: 'Unknown' }
                ])
              end
              regular_properties_association.create!(code: 'recipient_mobile_number',
                name: 'Recipient Mobile Number',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 20)
              end
              regular_properties_association.create!(code: 'recipient_address',
                name: 'Recipient Address',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 200)
              end
              regular_properties_association.create!(code: 'recipient_address_longitude',
                name: 'Recipient Address Long',
                type: :decimal,
                precision: 8,
                scale: 6,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :blank,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_numericality_validation(minimum: -90, includes_minimum: false, maximum: 90, includes_maximum: false, only_integer: false)
              end
              regular_properties_association.create!(code: 'recipient_address_latitude',
                name: 'Recipient Address Lat',
                type: :decimal,
                precision: 9,
                scale: 6,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :blank,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_numericality_validation(minimum: -180, includes_minimum: false, maximum: 180, includes_maximum: false, only_integer: false)
              end
              regular_properties_association.create!(code: 'delivery_method_code',
                name: 'Delivery Method Code',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :blank,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(code: 'deliverer_name',
                name: 'Deliverer Name',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :blank,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_length_validation!(maximum: 20)
              end
              regular_properties_association.create!(code: 'deliverer_mobile_number',
                name: 'Deliverer Mobile Number',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :blank,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_length_validation!(minimum: 11, maximum: 11)
                property.create_numericality_validation(only_integer: true)
              end
              regular_properties_association.create!(code: 'invoice_title',
                name: 'Invoice Title',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :blank,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(code: 'unified_social_credit_code',
                name: 'USCC',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :blank,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(code: 'new_user',
                name: 'New?',
                type: :boolean,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :blank,
                  on_actions: :all
                }
              )
              regular_properties_association.create!(code: 'followed_user',
                name: 'Followed?',
                type: :boolean,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :blank,
                  on_actions: :all
                }
              )
              regular_properties_association.create!(code: 'product_original_price',
                name: 'Product Original Price',
                type: :decimal,
                precision: 10,
                scale: 2,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_numericality_validation!(only_integer: false)
              end
              regular_properties_association.create!(code: 'packing_charge',
                name: 'Packing Charge',
                type: :decimal,
                precision: 6,
                scale: 2,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_numericality_validation!(only_integer: false)
              end
              regular_properties_association.create!(code: 'delivery_fee',
                name: 'Delivery Fee',
                type: :decimal,
                precision: 6,
                scale: 2,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_numericality_validation!(only_integer: false)
              end
              regular_properties_association.create!(code: 'total_original_price',
                name: 'Total Original Price',
                type: :decimal,
                precision: 8,
                scale: 2,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_numericality_validation!(only_integer: false)
              end
              regular_properties_association.create!(code: 'service_fee',
                name: 'Service Fee',
                type: :decimal,
                precision: 6,
                scale: 2,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_numericality_validation!(only_integer: false)
              end
              regular_properties_association.create!(code: 'revenue',
                name: 'Revenue',
                type: :decimal,
                precision: 6,
                scale: 2,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_numericality_validation!(only_integer: false)
              end
              regular_properties_association.create!(code: 'paid_at',
                name: 'Paid Time',
                type: :datetime,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_presence_validation!
              end
              regular_properties_association.create!(code: 'remarks',
                name: 'Remarks',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_length_validation!(maximum: 200)
              end
            end
          end
          Cascade.create!(source: platform, destination: platform_order, type: :has_many, optional: false, action_when_owner_destroyed: :restrict_with_exception, action_when_child_destroyed: :nothing).tap do |cascade|
            cascade.redundancies.create!(model: brand)
            cascade.redundancies.create!(model: station)
          end
          platform_review = project.models.create!(code: 'platform_review', name: 'Platform Review').tap do |model|
            model.create_orm_loggable!(on_create: true, on_update: true, on_destroy: true, comment_required: false)
            model.regular_properties.tap do |regular_properties_association|
              regular_properties_association.create!(code: 'number',
                name: 'Number',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_presence_validation!
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(code: 'order_number',
                name: 'Order Number',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :blank,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_length_validation!(maximum: 50)
              end
              regular_properties_association.create!(code: 'service_rating',
                name: 'Service Rating',
                type: :integer,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :not_allowed,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_presence_validation!
                property.create_numericality_validation!(minimum: 1, includes_minimum: true, maximum: 5, includes_maximum: true, only_integer: true)
              end
              regular_properties_association.create!(code: 'content',
                name: 'Content',
                type: :string,
                sculpture: false,
                common_validation_attributes: {
                  empty_tolerance: :blank,
                  on_actions: :all
                }
              ).tap do |property|
                property.create_length_validation!(maximum: 200)
              end
            end
          end
          Cascade.create!(source: platform, destination: platform_review, type: :has_many, optional: false, action_when_owner_destroyed: :restrict_with_exception, action_when_child_destroyed: :nothing).tap do |cascade|
            cascade.redundancies.create!(model: brand)
            cascade.redundancies.create!(model: station)
          end
          project.namespaces.create!(authenticator: Model.find_by(code: 'administrator'), name: 'admin', module: 'administration', path: 'admin', theme: :boooya_default).tap do |namespace|
            namespace.resourceful_controllers.create!(model: Model.find_by(code: 'station')).tap do |resourceful_controller|
              resourceful_controller.retrieve_collections.create!(type: :regular, action_code: 'index')
              resourceful_controller.create_retrieve_element!(type: :regular)
              resourceful_controller.create_individual_creation!(type: :regular, confirmable: true)
              resourceful_controller.create_individual_updation!(type: :regular, confirmable: true)
              resourceful_controller.create_individual_deletion!(type: :regular, confirmable: true)
            end
          end
        end
      end
    end unless Rails.env.production?
    p "finished in #{bench.real.round(2)} second(s), at #{Time.now.strftime('%Y-%m-%d %H:%M')}"
  end
end
