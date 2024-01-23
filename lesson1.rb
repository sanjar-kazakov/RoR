# puts "What's ur name?"
# name = gets.chomp

# puts "Hi, #{name}! What's ur birth year?"
# year = gets.to_i

# puts "You r #{2023 - year} years old "


def water_status(minutes)
    if minutes < 7
      puts "The water is not boiling yet."
    elsif minutes == 7
      puts "It's just barely boiling"
    elsif minutes == 8
      puts "It's boiling!"
    else
      puts "Hot! Hot! Hot!"
    end
  end

water_status(6)
water_status(7)
water_status(8)
water_status(11)