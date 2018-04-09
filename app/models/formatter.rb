class Formatter < ApplicationRecord
  belongs_to :formattable, polymorphic: true
end
