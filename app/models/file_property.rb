class FileProperty < Property
  has_many :image_uploaders, dependent: :destroy
  after_initialize :set_type

  protected
    def set_type
      self.type = :special
    end
end
