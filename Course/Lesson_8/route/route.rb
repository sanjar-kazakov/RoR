require_relative '../helpers/instance_counter'
require_relative '../helpers/validation'
require_relative 'actions'

# Route class
class Route
  include InstanceCounter
  include Validation
  include RouteActions

  attr_accessor :route_stations

  def initialize(first_station, last_station)
    @route_stations = [first_station, last_station]
    validate!
    register_instance
  end

  ROUTE_NAME_FORMAT = /^[a-zA-Z]{1,10}$/.freeze

  def add_int_station(int_station)
    route_stations.insert(-2, int_station)
  end

  def remove_int_station(int_station)
    return unless route_stations.include?(int_station) && (route_stations.size > 2)

    route_stations.delete(int_station)
  end
end
