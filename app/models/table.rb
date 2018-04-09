class Table < ApplicationRecord
  belongs_to :listable, polymorphic: true
  belongs_to :model
  has_one :pagination, class_name: "TablePagination", dependent: :destroy
  has_one :filter, class_name: "TableFilter", dependent: :destroy
  has_many :elements, class_name: "TableElement", dependent: :destroy
  has_many :regular_columns
  has_many :popover_columns
  after_create :set_elements

  protected
    def set_elements
      model.properties.sorted.each do |property|
        regular_columns.create!(property: property)
      end
    end
end
