class Form < ApplicationRecord
  belongs_to :formable, polymorphic: true
  belongs_to :model
  has_many :elements, class_name: "FormElement", dependent: :destroy
  has_many :regular_rows
  has_many :image_rows
  after_create :set_elements

  protected
    def set_elements
      model.properties.each do |property|
        case property
        when RegularProperty
          case property.type
          when "string"
            regular_rows.create!(property: property)
          when "text"
            regular_rows.create!(property: property)
          when "integer", "float", "decimal"
            regular_rows.create!(property: property).tap do |regular_row|
              regular_row.create_number_formatter!
            end
          when "date", "time", "datetime"
            regular_rows.create!(property: property).tap do |regular_row|
              regular_row.create_datetime_formatter!
            end
          when "boolean"
            regular_rows.create!(property: property).tap do |regular_row|
              regular_row.create_boolean_formatter!
            end
          when "array"
          end
        when FileProperty
          image_rows.create!(property: property)
        when EnumerationProperty
          regular_rows.create!(property: property)
        end
      end
    end
end
