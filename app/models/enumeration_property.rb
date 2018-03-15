class EnumerationProperty < Property
  has_many :elements, class_name: 'EnumerationElement', dependent: :destroy
  accepts_nested_attributes_for :elements
  after_initialize :set_type

  protected
    def set_type
      self.type = :special
    end
end
