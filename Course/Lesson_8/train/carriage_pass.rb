# Passenger carriage class
class PassCarriage < Carriage
  attr_accessor :seats, :seats_taken

  def initialize(seats)
    @type = :passenger
    @seats = seats
    @seats_taken = 0
    super()
  end

  def take_a_seat
    return (puts "Мест свободных больше нет") unless @seats_taken < @seats

    @seats_taken += 1
  end

  def seats_occupied
    @seats_taken
  end

  def seats_avaliable
    @seats - @seats_taken
  end
end

# pass = PassCarriage.new
