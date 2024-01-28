puts "To calculate the area of a triangle, we need to know its dimensions."
puts "First, enter the length of its base:"
base = gets.to_f

puts "Now, enter its height:"
height = gets.to_f

triangle_area = 1.0/2 * base * height
puts "The are of this triangle is: #{triangle_area}"