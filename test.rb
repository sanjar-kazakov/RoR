1.step(9,2) do |n|
    puts "#{n} situp"
    puts "#{n} pushup"
    puts "#{n} chinup"
end


flyers = []

class Flyer
    attr_reader :name, :email, :miles_flown
  
    def initialize(name, email, miles_flown)
      @name = name
      @email = email
      @miles_flown = miles_flown
    end
  
    def to_s
      "#{name} (#{email}): #{miles_flown}"
    end

    def this_is_a_block
        yield
        yield
        yield
    end
    
    this_is_a_block {puts "This is a block"}
end

flyer = Flyer.new("flyer1", "flyer@example.com", 1000)

1.upto(5) do |n|
    flyers << Flyer.new("flyer#{n}", "flyer#{n}@example.com", n * 1000)
end

puts flyers




