# Заполнить массив числами фибоначчи до 100

# Создаем массив, в котором начальные значения [1,1], 
# и по логике сложения двух последних чисел в массиве, добавляем получившееся число в конец массива.

fib = [1,1]

(2..100).each do 
    fib_num = fib[-1] + fib[-2]
    break if fib_num > 100
    fib << fib_num
end
p fib



fib = [1, 1]

(2..100).each do
  fib_num = fib.last(2).sum
  break if fib_num > 100
  fib << fib_num
end

p fib
