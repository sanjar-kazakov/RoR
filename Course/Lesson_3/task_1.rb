class Station

    attr_accessor :name, :trains

    def initialize(name)
        @name = name
        @trains = []
    end

    def add_train(train)
        @trains << train
    end

    # создали метод, что вводя название в параметры метода, он будет удалять его из массива @trains = []
    def depart_train(train)
        @trains.delete(train)
    end

    # Обращаемся к массиву @trains, используя метод select, который возвращает новый массив, 
    # содержащий только те элементы из @trains, для которых блок возвращает true. 
    # В данном случае блок проверяет, равен ли тип поезда (train.type) переданному типу (type).
    def trains_by_type(type)
        @trains.select do |train|
            train.type == type
        end
    end


end


class Route

    def initialize(first_station, last_station)
        @stations = [@first_station = first_station,
            @intermediate_station = [],
            @last_station = last_station]
    end

    def add_int_station(int_station)
        @intermediate_station << int_station
    end

    def remove_int_station(int_station)
        @intermediate_station.delete.include?(int_station)
    end

    def show_station
        return @stations
    end
end


class Train

    attr_accessor :speed, :num, :type, :carriages, :current_station_num

    def initialize(num, type, carriages)
        @num = num
        @type = type
        @carriages = carriages
        @speed = 0
    end

    def accelerate
        @speed += 10 
    end

    def brake
        @speed = 0
    end

    # def carriage_num(carriages)
    #     @carriages = carriages
    # end

    def add_carriage
        @carriages += 1 if @speed = 0
    end
    
    def remove_carriage
        @carriages -= 1 if @speed = 0
    end
    
    def set_route(route)
        @route = route
        @current_station_num = 0
        current_station.add_train(self)
    end

    def move_forward
        return unless next_station
    
        current_station.send_train(self)
        @current_station_num += 1
        current_station.accept_train(self)
    end
    
    def move_backward
        return unless previous_station
    
        current_station.send_train(self)
        @current_station_num -= 1
        current_station.accept_train(self)
    end

    def previous_station
        @route.stations[@current_station_num - 1] if @current_station_num.positive?
    end
    
    def current_station
        @route.stations[@current_station_num]
    end
    
    def next_station
        @route.stations[@current_station_num + 1] if @current_station_num < @route.stations.size - 1
    end

end