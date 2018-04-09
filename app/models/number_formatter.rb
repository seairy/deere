class NumberFormatter < Formatter
  validates :includes_sign, inclusion: { in: [true, false] }, allow_blank: true
  validates :placeholder, length: { maximum: 100 }
  validates :precision, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 64 }, allow_blank: true
  validates :strip_insignificant_zeros, inclusion: { in: [true, false] }, allow_blank: true
  validates :delimiter, length: { maximum: 100 }
end
