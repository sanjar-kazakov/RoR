require_relative '../helpers/instance_counter'
require_relative '../helpers/validation_new'

#  Station class
class Station
  include InstanceCounter
  include Validation

  def self.all
    @all_stations = []
  end

  NAME_FORMAT = /^[a-zA-Z]{1,10}$/.freeze

  attr_accessor :name, :trains

  validate :name, :presence
  validate :name, :format, NAME_FORMAT

  def initialize(name)
    @name = name
    @trains = []
    validate!
    self.class.all << self
    register_instance
  end

  def add_train(train)
    @trains << train
  end

  def depart_train(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    @trains.select do |train|
      train.type == type
    end
  end

  def each_train(&block)
    @trains.each { |train| block.call(train) }
  end
end
