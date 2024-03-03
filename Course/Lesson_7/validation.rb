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
            train_validation
        when Route
            route_validation
        when Station
            station_validation
        end
    end

    def train_validation
        unless number =~ Train::NUMBER_FORMAT
            raise "Неверный формат номера поезда!" \
                  "Правильный формат - три буквы, две цифры (ABC-22)!!!"
        end
    end

    def route_validation
        unless route_stations.all? { |stations| stations =~ Route::ROUTE_NAME_FORMAT }
        raise "Название должно состоять только из латинских букв в количестве не более 10."
        end
    end

    def station_validation
        raise "Название должно состоять только из латинских букв." if name !~ Station::NAME_FORMAT
        raise "Название должно состоять из не более 10 букв." if name.length > 10
    end
end
