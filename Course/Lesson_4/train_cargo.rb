class CargoTrain < Train

    attr_reader :carriages

    def initialize(number, type)
      super(number, type)
    end
end
