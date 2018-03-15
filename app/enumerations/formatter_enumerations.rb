module FormatterEnumerations
  extend Enumerize
  enumerize :formatter, in: %w(boolean date time datetime currency quantity), predicates: { prefix: true }, scope: true
end
