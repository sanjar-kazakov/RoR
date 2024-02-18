require_relative 'instance_counter'

class Station
include InstanceCounter

    attr_accessor :name, :trains

    @@all_stations = []

    def self.all
        @@all_stations
    end

    def initialize(name)
        @name = name
        @trains = []
        @@all_stations << self
        register_instance
    end

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