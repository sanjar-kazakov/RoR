puts "Enter coefficient a:"
a = gets.to_i 

puts "Enter coefficient b:"
b = gets.to_i 

puts "Enter coefficient c:"
c = gets.to_i

D = (b**2 - 4 * a * c)

if 
    D > 0
        x1 = (-b + Math.sqrt(D)) / (2 * a)
        x2 = (-b - Math.sqrt(D)) / (2 * a)
    puts "Дискриминант #{D}, корень 1: #{x1}, корень 2: #{x2}"

elsif
    D == 0
        x1 = (-b + Math.sqrt(D)) / (2 * a)
        x2 = (-b - Math.sqrt(D)) / (2 * a)
    puts "Дискриминант #{D}, корень: #{x1}"
else
    puts "Дискриминант #{D}, Корней нет"

end