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
            raise "Неверный формат номера поезда! \n Правильный формат - три буквы, две цифры (ABC-22)!!!" unless number =~ Train::NUMBER_FORMAT 
        when Route
            # raise "Начальная и конечная станции обязательны!" if (route_stations[0] && route_stations[1]).nil?
            raise "Название должно состоять только из латинских букв в количестве не более 10." unless route_stations.all? { |stations| stations =~ Route::ROUTE_NAME_FORMAT}
        when Station
            # raise "Название станции обязательно!" if name.nil?
            raise "Название должно состоять только из латинских букв." if name !~ Station::NAME_FORMAT
            raise "Название должно состоять из не более 10 букв." if name.length > 10
        end
    end
end