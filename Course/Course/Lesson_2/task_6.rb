products = {}

total_cost = 0

puts "Enter 'stop' to abort entry"
puts "-" * 30
loop do
    puts "Enter the product title:"
    title = gets.chomp.capitalize
    break if title == "Stop"

    puts "Enter the product price:"
    price = gets.chomp.to_f

    puts "Enter the product quantity:"
    quantity = gets.chomp.to_f

    products[title] = {
    price: price,
    quantity: quantity
    }

    total_cost += price * quantity
end

puts products


products.each do |title, details|
    product_cost = details[:quantity] * details[:price]
    
    puts "Product in the cart: #{title} \n 
        Quantity: #{details[:quantity]} \n 
        Price: #{details[:price]} \n 
        Cost: #{product_cost}"
    puts "-" * 20

    # total_cost += product_cost

end

puts "The total cost of the order: #{total_cost}"
