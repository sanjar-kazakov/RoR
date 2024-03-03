require_relative 'instance_counter'
require_relative 'validation'

class Route
    include InstanceCounter
    include Validation
    

    attr_accessor :route_stations

    def initialize(first_station, last_station)
        @route_stations = [first_station, last_station]
        validate!
        register_instance
    end

    ROUTE_NAME_FORMAT = /^[a-zA-Z]{1,10}$/

    def add_int_station(int_station)
        route_stations.insert(-2, int_station)
    end

    def remove_int_station(int_station)
        if (route_stations.include?(int_station)) && (route_stations.size > 2)
        route_stations.delete(int_station)
        else
        end
    end
end
