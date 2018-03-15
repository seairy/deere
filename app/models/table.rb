class Table < ViewElement
  has_one :pagination, class_name: 'TablePagination', dependent: :destroy
  has_many :columns, class_name: 'TableColumn', dependent: :destroy
  validates :include_sequence_number, inclusion: { in: [true, false] }
end
