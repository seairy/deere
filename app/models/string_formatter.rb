class StringFormatter < Formatter
  validates :maximum_length, numericality: { only_integer: true, greater_than: 0 }, allow_blank: true
end
