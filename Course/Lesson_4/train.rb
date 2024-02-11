class Train

    attr_accessor :speed, :type, :number, :current_station_num, :carriages, :route

    def initialize(number, type)
        @number = number
        @type = type
        @speed = 0
        @carriages = []
    end

    def accelerate
        @speed += 10 
    end

    def brake
        @speed = 0
    end

    def set_route(route)
        @route = route
        @current_station_num = 0
        current_station
    end

    def previous_station
        route.route_stations[@current_station_num - 1] unless @route.nil?
    end
    
    def current_station
        route.route_stations[@current_station_num]
    end
    
    def next_station
        route.route_stations[@current_station_num + 1] unless @route.nil?
        # require 'pry'; binding.pry
    end
    
    def move_forward
        @current_station_num += 1 if next_station
    end
    
    def move_backward
        @current_station_num -= 1 if previous_station
    end

    def add_carriage(carriage)
        @carriages << carriage if @speed == 0
    end

    def remove_carriage
        @carriages.delete_at(-1) if @speed == 0
    end

end