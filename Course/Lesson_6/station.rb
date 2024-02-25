require_relative 'instance_counter'
require_relative 'validation'


class Station
include InstanceCounter
include Validation

    attr_accessor :name, :trains

    @@all_stations = []

    def self.all
        @@all_stations
    end

    def initialize(name)
        @name = name
        @trains = []
        validate!
        @@all_stations << self
        register_instance
    end

    NAME_FORMAT = /^[a-zA-Z]+$/ # здесь мог добавить сразу валидацию на кол-во символов, 
    # не знал насколько нужно было показать валидацию на кол-во символов отдельным методом. 
    # Если не критично, исправлю в следующем задании

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

end