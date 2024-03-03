class PassCarriage < Carriage
    
    attr_accessor :seats, :seats_taken
    
    def initialize(seats)
        @type = :passenger
        @seats = seats
        @seats_taken = 0
        super()
    end

    def take_a_seat
     if @seats_taken < @seats
        @seats_taken += 1
    else
        return (puts "Мест свободных больше нет")
    end
    end

    def seats_occupied
        @seats_taken
    end

    def seats_avaliable
        @seats - @seats_taken
    end
end





# pass = PassCarriage.new
