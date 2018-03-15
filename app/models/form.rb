class Form < ViewElement
  has_many :groups, class_name: 'FormGroup', dependent: :destroy
  has_many :text_fields, dependent: :destroy
end
