require_relative 'company'

class Carriage
    include Company
    
    attr_reader :type
end