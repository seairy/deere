class TextField < FormGroup
  validates :read_only, inclusion: { in: [true, false] }
end
