class ListingLogic < ViewLogic
  extend Enumerize
  enumerize :type, in: %w(regular), predicates: { prefix: true }, scope: true
  validates :model, uniqueness: true

  def restriction_of_elements
    base_restriction_of_elements({
      'regular' => [{ class_name: 'table', maximum_count: 1 }, { class_name: 'form', maximum_count: 0 }]
    })
  end
end
