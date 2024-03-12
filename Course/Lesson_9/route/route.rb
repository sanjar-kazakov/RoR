require_relative '../helpers/instance_counter'
require_relative '../helpers/validation_new'
require_relative 'actions'

# Route class
class Route
  include InstanceCounter
  include Validation
  include RouteActions

  ROUTE_NAME_FORMAT = /^[a-zA-Z]{1,10}$/.freeze

  attr_accessor :route_stations

  validate :first_station, :presence
  validate :last_station, :presence
  validate :first_station, :format, ROUTE_NAME_FORMAT
  validate :last_station, :format, ROUTE_NAME_FORMAT

  def initialize(first_station, last_station)
    @route_stations = [first_station, last_station]
    validate!
    register_instance
  end

  def add_int_station(int_station)
    route_stations.insert(-2, int_station)
  end

  def remove_int_station(int_station)
    return unless route_stations.include?(int_station) && (route_stations.size > 2)

    route_stations.delete(int_station)
  end
end
