
# Вариант с переводом хеша в массив.
# Но я так понимаю, что такой вариант совсем ни к чему, верно?
month_hash = {
    january: 31, 
    february: 29, 
    march: 31, 
    april: 30, 
    may: 31, 
    june: 30, 
    july: 31, 
    august: 31, 
    september: 30,
    october: 31,
    november: 30,
    december: 31
}

arr = month_hash.to_a

arr.each do |months, days|

puts months, days if days == 30
end



# Без перевода в массив

month_hash = {
    january: 31, 
    february: 29, 
    march: 31, 
    april: 30, 
    may: 31, 
    june: 30, 
    july: 31, 
    august: 31, 
    september: 30,
    october: 31,
    november: 30,
    december: 31
}

month_hash.each do |months, days|

puts months, days if days == 30
end


month_hash = {
    january: 31, 
    february: 29, 
    march: 31, 
    april: 30, 
    may: 31, 
    june: 30, 
    july: 31, 
    august: 31, 
    september: 30,
    october: 31,
    november: 30,
    december: 31
}

month_hash.each do |months, days|

puts "30 days months in 2024: #{months}, #{days}" if days == 30
end



month_hash = {
    january: 31, 
    february: 29, 
    march: 31, 
    april: 30, 
    may: 31, 
    june: 30, 
    july: 31, 
    august: 31, 
    september: 30,
    october: 31,
    november: 30,
    december: 31
}

month_hash.each do |months, days|

puts "30 days months in 2024: #{months.capitalize}" if days == 30
end