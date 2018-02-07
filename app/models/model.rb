class Model < ApplicationRecord
  serialize :includes_classes, Array
  serialize :extends_classes, Array
  belongs_to :project
  has_one :orm_loggable
  has_one :authenticatable
  has_one :sortable
  has_one :trashable
  has_one :state_machine
  has_many :properties
  has_many :regular_properties
  has_many :enumeration_properties
  has_many :file_properties
  has_many :cascades_as_source, class_name: 'Cascade', foreign_key: 'source_id'
  has_many :cascades_as_destination, class_name: 'Cascade', foreign_key: 'destination_id'
  validates :includes_classes, length: { maximum: 1000 }
  validates :extends_classes, length: { maximum: 1000 }
  validates :name, presence: true, length: { maximum: 100 }, format: /\A\w+\Z/
  validates :zh_name, presence: true, length: { maximum: 100 }
  validates :en_name, presence: true, length: { maximum: 100 }

  def cascade_ids
    [cascades_as_source.pluck(:destination_id), cascades_as_destination.pluck(:source_id)].flatten.compact
  end

  def owners level
    models_in_chain(:owner, level)
  end

  def children level
    models_in_chain(:child, level)
  end

  protected
    def models_in_chain direction, level
      raise ArgumentError.new('invalid direction, only can be :owner or :child') if direction != :owner and direction != :child
      raise ArgumentError.new('level is not a valid number') unless level.is_a?(Integer)
      raise ArgumentError.new('level must be greater than zero') if level < 1
      [[self]].tap do |array|
        (1..level).each do |current_level|
          break if array.last.blank?
          array << array.last.map{|model| model.send("cascades_as_#{case direction when :owner then 'destination' when :child then 'source' end}").map{|cascade| cascade.send("#{case direction when :owner then 'source' when :child then 'destination' end}")}}.flatten
        end
      end.drop(1).flatten
    end
end
