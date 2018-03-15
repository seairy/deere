class Model < ApplicationRecord
  serialize :includes_classes, Array
  serialize :extends_classes, Array
  belongs_to :project
  has_one :orm_loggable, dependent: :destroy
  has_one :authenticatable, dependent: :destroy
  has_one :sortable, dependent: :destroy
  has_one :trashable, dependent: :destroy
  has_one :state_machine, dependent: :destroy
  has_many :submodels, dependent: :destroy
  has_many :properties, dependent: :destroy
  has_many :regular_properties, dependent: :destroy
  has_many :hash_properties, dependent: :destroy
  has_many :enumeration_properties, dependent: :destroy
  has_many :file_properties, dependent: :destroy
  has_many :cascades_as_source, class_name: 'Cascade', foreign_key: 'source_id', dependent: :destroy
  has_many :cascades_as_destination, class_name: 'Cascade', foreign_key: 'destination_id', dependent: :destroy
  has_many :custom_validations, dependent: :destroy
  has_many :presenters, dependent: :destroy
  has_many :model_files, dependent: :destroy
  has_many :migration_files, dependent: :destroy
  has_many :controller_files, dependent: :destroy
  validates :project, presence: true
  validates :includes_classes, length: { maximum: 1000 }
  validates :extends_classes, length: { maximum: 1000 }
  validates :code, presence: true, length: { maximum: 100 }, uniqueness: { scope: :project }, code: true
  validates :localized_name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :project }
  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :project }

  def cascade_ids
    [cascades_as_source.pluck(:destination_id), cascades_as_destination.pluck(:source_id)].flatten.compact
  end

  def belongs level
    siblings(:up, level)
  end

  def has level
    siblings(:down, level)
  end

  protected
    def siblings direction, level
      raise ArgumentError.new('invalid direction, only can be :up or :down') if direction != :up and direction != :down
      raise ArgumentError.new('level is not a valid number') unless level.is_a?(Integer)
      raise ArgumentError.new('level must be greater than zero') if level < 1
      [[self]].tap do |array|
        (1..level).each do |current_level|
          break if array.last.blank?
          array << array.last.map{|model| model.send("cascades_as_#{case direction when :up then 'destination' when :down then 'source' end}").map{|cascade| cascade.send("#{case direction when :up then 'source' when :down then 'destination' end}")}}.flatten
        end
      end.drop(1).flatten
    end
end
