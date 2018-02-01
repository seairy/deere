class FileProperty < Property
  has_many :image_uploaders, dependent: :destroy
  before_create :set_type

  protected
    def set_type
      self.type = :special
    end
end
