# User choice
module UserActions
  def ask_for_action(choice)
    user_actions = {
      1 => method(:create_station),
      2 => method(:remove_station),
      3 => method(:show_stations),
      4 => method(:create_train),
      5 => method(:add_carriage),
      6 => method(:remove_carriage),
      7 => method(:show_trains),
      8 => method(:add_train_to_station),
      9 => method(:train_list),
      10 => method(:cargo_list),
      11 => method(:occupy),
      12 => method(:create_route),
      13 => method(:display_routes),
      14 => method(:set_route),
      15 => method(:add_station),
      16 => method(:remove_route_station),
      17 => method(:move_next_station),
      18 => method(:move_previous_station),
      19 => method(:find_train_by_number),
      20 => method(:exit)
    }

    action = user_actions[choice]
    action&.call
  end

  def make_choice
    gets.chomp.to_i
  end

  def ask(question)
    puts question
    gets.chomp
  end

  def choice_validation(title, item, number)
    puts "Выберите #{title}:"
    item.each_with_index do |n, i|
      puts " #{i + 1}. #{n.send(number)}"
    end

    index = gets.chomp.to_i - 1
    puts "Неверный выбор!" if item[index].nil?

    item[index]
  end

  def asking_for_train_data
    number = ask("Введите номер поезда:")
    raise "Необходимо ввести номер поезда" if number.empty?

    type = ask("Выберите тип поезда: \n1. Passenger \n2. Cargo").to_i

    { number: number, type: type }
  end
end
