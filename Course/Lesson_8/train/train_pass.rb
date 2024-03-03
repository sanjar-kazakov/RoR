# Cargo passenger class
class PassTrain < Train
  def initialize(number)
    @type = :passenger
    super
  end
end
