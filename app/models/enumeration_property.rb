class EnumerationProperty < Property
  has_many :elements, class_name: 'EnumerationElement', dependent: :destroy
  before_create :set_type

  protected
    def set_type
      self.type = :special
    end
end
