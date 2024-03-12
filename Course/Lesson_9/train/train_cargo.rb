# Cargo train class
class CargoTrain < Train
  def initialize(number)
    @type = :cargo
    super
  end
end
