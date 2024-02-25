module Validation

    def valid?
        validate!
        true
    rescue
        false
    end

    def validate!
        case self
        when Train
            raise "Необходимо ввести номер поезда" if number.nil?
            raise "Wrong number format!!!" unless number =~ Train::NUMBER_FORMAT 
        when Route
            raise "Начальная и конечная станции обязательны!" if (route_stations[0] && route_stations[1]).nil?
        when Station
            raise "Название станции обязательно!" if name.nil?
            raise "Название должно состоять только из латинских букв." if name !~ Station::NAME_FORMAT
            raise "Название должно состоять из не более 10 букв." if name.length > 10
        end
    end
end

class Train
include Validation

    attr_accessor :number
    def initialize(number = nil)
        @number = number
        validate!
    end

    NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i
end

class Route
    include Validation

    attr_accessor :route_stations

    def initialize(first_station = nil, last_station = nil)
        @route_stations = [first_station, last_station]
        validate!
    end
end

class Station
    include Validation
    
    attr_accessor :name

    def initialize(name = nil)
        @name = name
        validate!
    end
     
    NAME_FORMAT = /^[a-zA-Z]{1,10}$/
end



train = Train.new("ABC-22")
route = Route.new("Minsk", "Moscow")
station = Station.new("grodno")