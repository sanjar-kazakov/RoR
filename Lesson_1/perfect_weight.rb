puts "What's your name?"
name = gets.chomp.capitalize

puts "Hi, #{name}! Could u please enter your height?"
height = gets.to_i

perfect_weight = (height - 110) * 1.15

if 
    perfect_weight < 0
    puts "#{name}, your weight is optimal"
else
    puts "#{name}, your perfect weight is: #{perfect_weight}kg"
end


# def water_status(minutes)
#     if minutes < 7
#       puts "The water is not boiling yet."
#     elsif minutes == 7
#       puts "It's just barely boiling"
#     elsif minutes == 8
#       puts "It's boiling!"
#     else
#       puts "Hot! Hot! Hot!"
#     end
# end

# water_status(6)
# water_status(7)
# water_status(8)
# water_status(11)