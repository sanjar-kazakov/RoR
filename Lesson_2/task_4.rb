# Заполнить хеш гласными буквами, где значением будет являться порядковый номер буквы в алфавите (a - 1).

my_hash = Hash.new(0)

vowels = ['a', 'e', 'i', 'o', 'u']

("a".."z").each_with_index do |l, i|
    my_hash[l] += (i + 1) if vowels.include?(l)
end
p my_hash


# не знаю что лучше

my_hash = {}

vowels = ['a', 'e', 'i', 'o', 'u']
("a".."z").each_with_index do |l, i|
    i = i + 1
    my_hash[l] = i if vowels.include?(l)
end
p my_hash