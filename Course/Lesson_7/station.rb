require_relative 'instance_counter'
require_relative 'validation'


class Station
include InstanceCounter
include Validation

    @@all_stations = []

    def self.all
        @@all_stations
    end

    attr_accessor :name, :trains

    def initialize(name)
        @name = name
        @trains = []
        validate!
        @@all_stations << self
        register_instance
    end

    NAME_FORMAT = /^[a-zA-Z]+$/.freeze # здесь мог добавить сразу валидацию на кол-во символов,
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

    def each_train(&block)
        @trains.each { |train| block.call(train) }
    end
end
