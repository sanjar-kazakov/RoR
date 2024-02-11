class Station

    attr_accessor :name, :trains

    def initialize(name)
        @name = name
        @trains = []
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