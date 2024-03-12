require_relative 'company'
require_relative 'actions'

# Parrent carriage class
class Carriage
  include Company
  include TrainActions

  attr_reader :type
  attr_accessor :seats
end
