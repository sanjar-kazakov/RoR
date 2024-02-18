require_relative 'company'

class Carriage

    include Company
    
    attr_accessor :carriages

    def initialize(type)
        @type = type
    end
end