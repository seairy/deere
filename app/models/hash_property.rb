class HashProperty < Property
  has_many :serialized_hashes
  before_create :set_type

  protected
    def set_type
      self.type = :special
    end
end
