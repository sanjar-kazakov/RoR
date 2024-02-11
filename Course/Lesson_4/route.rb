class Route

    attr_accessor :route_stations

    def initialize(first_station, last_station)
        @route_stations = [first_station, last_station]
    end

    def add_int_station(int_station)
        self.route_stations.insert(-2, int_station)
    end

    def remove_int_station(int_station)
        if (self.route_stations.include?(int_station)) && (route_stations.size > 2)
        self.route_stations.delete(int_station)
        else
        end
    end
    
    # def station
    #     @route_stations
    # end
end