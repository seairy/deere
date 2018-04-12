class SourceCode < ApplicationRecord
  serialize :prefix, Array
  belongs_to :project
  before_save :format_content
  validates :prefix, presence: true, length: { maximum: 1000 }
  validates :file_name, presence: true, length: { maximum: 255 }
  validates :extension, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 65535 }

  protected
    def format_content
      case extension
      when "rb"
        self.content = Rufo::Formatter.format(content)
      end
    end
end
