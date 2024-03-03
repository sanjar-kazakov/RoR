class CargoCarriage < Carriage
    
    attr_accessor :volume, :volume_taken

    def initialize(volume)
        @type = :cargo
        @volume = volume
        @volume_taken = 0
        super()
    end

    def occupy_volume(volume)
        @volume_taken += volume 
    end

    def occupied_volume
        @volume_taken
    end

    def remaining_volume
        @volume - @volume_taken
    end
end

# cargo = CargoCarriage.new(5)
