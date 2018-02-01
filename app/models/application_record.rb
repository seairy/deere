class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  self.inheritance_column = :inheritance_type
end
