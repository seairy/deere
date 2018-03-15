class HashProperty < Property
  has_many :serialized_hashes
  accepts_nested_attributes_for :serialized_hashes
  after_initialize :set_type

  protected
    def set_type
      self.type = :special
    end
end
