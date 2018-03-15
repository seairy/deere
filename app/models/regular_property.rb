class RegularProperty < Property
  validates :type, presence: true
  validates :precision, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 64 }, if: lambda { |regular_property| regular_property.type_decimal? }
  validates :scale, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 30 }, if: lambda { |regular_property| regular_property.type_decimal? }
end
