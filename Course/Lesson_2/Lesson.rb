numbers = (10..20)

numbers.each do |number|
    puts number
end

puts "Enter any text below:"
text = gets.chomp

puts "Enter word to be changed below:"
redact = gets.chomp

words = text.split(" ")

words.each do |word|
puts word
end


words = ['Enter', ' word', ' to', ' be', ' changed', ' below']

words.each do |word|
puts word
end

puts "Enter any text below:"
text = gets.chomp

puts "Enter word to be changed below:"
redact = gets.chomp

words = text.split(" ")

words.each do |word|
if redact == word
puts "REDACTED "
break
else
puts word + " "
end
end

my_array = {
  cola: 3,
  fanta: 2,
  sprite: 1,
  water: 0.5
}

my_array.each do |drink, price|
  puts "#{drink}: #{price}$"
end

my_array = [
  {cola: 3},
  {fanta: 2},
  {sprite: 1},
  {water: 0.5}
]

my_array.each do |drink|
  drink.each do |name, price|
    puts "#{name}: #{price}$"
  end
end


frequencies = Hash.new(0)

puts "Enter anything:"
text = gets.chomp

words = text.split(" ")

words.each do |word|
frequencies[word] +=1
puts frequencies
end

frequencies = Hash.new(0)

puts "Enter anything:"
text = gets.chomp

words = text.split(" ")

words.each do |word|
    frequencies[word] +=1
    puts frequencies
end

frequencies = frequencies.sort_by do |sum, num|
    sum
end

frequencies.reverse!
puts frequencies

# -----------------------------------------------------
frequencies = Hash.new(0)

puts "Enter anything:"
text = gets.chomp

words = text.split(" ")

words.each do |word|
frequencies[word] +=1
puts frequencies
end

frequencies = frequencies.sort_by do |sum, num|
  sum
  puts sum + " " + num.to_s
end
frequencies.reverse!

# -----------------------------------------------------
creatures = { "weasels" => 0,
  "puppies" => 6,
  "platypuses" => 3,
  "canaries" => 1,
  "Heffalumps" => 7,
  "Tiggers" => 1
}
creatures.each do |key, value|
puts key if value == 9
end

# -----------------------------------------------------

Тут, из стринг делаем символы:
https://www.codecademy.com/courses/learn-ruby/lessons/hashes-and-symbols/exercises/converting-between-symbols-and-strings

strings = ["HTML", "CSS", "JavaScript", "Python", "Ruby"]
symbols = []

strings.each do |s| 
 symbols.push(s.to_sym)
end 
print symbols


# -----------------------------------------------------
# We mentioned that hash lookup is faster with symbol keys than with string keys. Here, we’ll prove it!

# The code in the editor uses some new syntax, so don’t worry about understanding all of it just yet. 
# It builds two alphabet hashes: one that pairs string letters with their place in the alphabet ( “a” with 1, “b” with 2…) 
# and one that uses symbols (:a with 1, :b with 2…). 
# We’ll look up the letter “r” 100,000 times to see which process runs faster!

# It’s good to keep in mind that the numbers you’ll see are only fractions of a second apart, 
# and we did the hash lookup 100,000 times each. 
# It’s not much of a performance increase to use symbols in this case, but it’s definitely there!

require 'benchmark'

string_AZ = Hash[("a".."z").to_a.zip((1..26).to_a)]
symbol_AZ = Hash[(:a..:z).to_a.zip((1..26).to_a)]

string_time = Benchmark.realtime do
  1000_000.times { string_AZ["r"] }
end

symbol_time = Benchmark.realtime do
  1000_000.times { symbol_AZ[:r] }
end

puts "String time: #{string_time} seconds."
puts "Symbol time: #{symbol_time} seconds."



# -----------------------------------------------------

Тут мы делаем выборку по данным в хеше:

movie_ratings = {
  memento: 3,
  primer: 3.5,
  the_matrix: 5,
  truman_show: 4,
  red_dawn: 1.5,
  skyfall: 4,
  alex_cross: 2,
  uhf: 1,
  lion_king: 3.5
}
# Add your code below!

good_movies = movie_ratings.select do |name, raiting|
puts name if raiting > 3
end



Тут мы делаем выборку по ключам в хеше:

movie_ratings = {
  memento: 3,
  primer: 3.5,
  the_matrix: 3,
  truman_show: 4,
  red_dawn: 1.5,
  skyfall: 4,
  alex_cross: 2,
  uhf: 1,
  lion_king: 3.5
}
# Add your code below!
movie_ratings.each_key do |k|
puts k
end


Тут мы делаем выборку по значениям в хеше:

movie_ratings = {
  memento: 3,
  primer: 3.5,
  the_matrix: 3,
  truman_show: 4,
  red_dawn: 1.5,
  skyfall: 4,
  alex_cross: 2,
  uhf: 1,
  lion_king: 3.5
}
# Add your code below!
movie_ratings.each_value do |v|
puts v
end



#-----------------------------------------
movies = {
  BreakingBad: 9,
  OnePlusOne: 8,
  Montenegro: 3,
  Blind: 6
}

puts "What would you like to do? "
puts "-- Type 'add' to add a movie."
puts "-- Type 'update' to update a movie."
puts "-- Type 'display' to display all movies."
puts "-- Type 'delete' to delete a movie."
choice = gets.chomp

case choice
when "add"
    puts "Please enter the title of the movie:"
    title = gets.chomp

  if movies[title.to_sym].nil?
    puts "Enter the rating of the movie from 0 to 10"
    rating = gets.chomp
    movies[title.to_sym] = rating.to_i
    puts "The #{title} with the rating #{rating} is added to the list!"
  else
    puts "The #{title} is already in the list!"
end
  
  
when "update"
    puts "Please enter the title of the movie:"
    title = gets.chomp
  if movies[title.to_sym].nil?
    puts "There is no such kind of movie"
  else
    puts "Enter a new rating of the #{title} from 0 to 10"
    rating = gets.chomp
    movies[title.to_sym] = rating
  end


when "display"
  puts "Here are the movies:"
  movies.each do |title, rating|
  puts "#{title}: #{rating}"
end


when "delete"
    puts "Please enter the title of the movie:"
    title = gets.chomp
  if movies[title.to_sym].nil?
    puts "There is no such kind of movie"
  else 
    movies.delete(title.to_sym)
    
  end

else
  puts "Error!!!"
end
