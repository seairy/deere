class TableFilter < ApplicationRecord
  belongs_to :table
  has_many :scopes, class_name: "TableFilterScope", dependent: :destroy
end
