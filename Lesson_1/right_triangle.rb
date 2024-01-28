puts "Enter the first side of a triangle:"
 a = gets.to_i


puts "Enter the second side of a triangle:"
b = gets.to_i


puts "Enter the third side of a triangle:"
c = gets.to_i

max_value = [a, b, c].max
# puts "Максимальное введенное значение #{max_value}"

# Для тестирования - значения (целые) сторон прямоугольного треугольника:
# 5 4 3
# 10 8 6
# 13 12 5
# 15 12 9
# 17 15 8
# 20 16 12
if 
        max_value**2 == a**2 + b**2 || max_value**2 == b**2 + c**2 || max_value**2 == a**2 + c**2
        puts "Прямоугольный"
    elsif
        a == b && b == c 
        puts "Равносторонний"
    elsif
        a == b || b == c || a == c
        puts "Равнобедренный"  
    else
        puts "Обычный"  
end