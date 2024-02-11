# 5. Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя). 
# Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным. 
# (Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?) 
# Алгоритм опредления високосного года: docs.microsoft.com


puts "Enter a day:"
day = gets.chomp.to_i

puts "Enter a month:"
month = gets.chomp.to_i

puts "Enter a year:"
year = gets.chomp.to_i

days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

leap_year = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)

if leap_year == true
    days_in_month[1] = 29
end

total_days = days_in_month[0...month - 1].sum + day

puts total_days

# можно еще с использованием метода take:
puts "Enter a day:"
day = gets.chomp.to_i

puts "Enter a month:"
month = gets.chomp.to_i

puts "Enter a year:"
year = gets.chomp.to_i

days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

leap_year = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)

if leap_year
    days_in_month[1] = 29
end

total_days = days_in_month.take(month - 1).sum + day

puts total_days
