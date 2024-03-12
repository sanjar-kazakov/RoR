require_relative '../helpers/validation_new'

# route action methods
module TrainActions
  include Validation

  def create_train
    train_data = asking_for_train_data
    case train_data[:type]
    when 1 then @trains << PassTrain.new(train_data[:number])
    when 2 then @trains << CargoTrain.new(train_data[:number])
    end
    puts "Поезд создан!"
  rescue StandardError => e
    puts e
    retry
  end

  def show_trains
    return if entity_empty?(@trains, "Поездов")

    puts "Созданные поезда:"
    @trains.each_with_index do |train, index|
      puts "#{index + 1}. #{train.type.capitalize}, №#{train.number}"
    end
  end

  def add_carriage
    train = choice_validation("поезд", @trains, :number)

    if train.type == :passenger
      pass_seats = ask("Введите количество мест в вагоне:").to_i
      train.add_carriage(PassCarriage.new(pass_seats))
    elsif train.type == :cargo
      cargo_volume = ask("Введите объем вагона:").to_i
      train.add_carriage(CargoCarriage.new(cargo_volume))
    else
      puts "Такого поезда нет"
    end
  end

  def remove_carriage
    return if entity_empty?(@trains, "Поездов")

    train = choice_validation("поезд", @trains, :number)

    if train.carriages.empty?
      puts "Вагонов у поезда нет"
    elsif train.remove_carriage
      puts "Вагон отцеплен"
    else
      puts "Такого поезда нет"
    end
  end

  def set_route
    return if entity_empty?(@trains, "Поездов") || entity_empty?(@routes, "Маршрутов")

    train = choice_validation("номер поезда", @trains, :number)
    route = choice_validation("маршрут", @routes, :route_stations)

    train.add_route(route)
    puts "Маршрут добавлен поезду: #{train.number}. Поезд на станции #{train.current_station}."
  end

  def move_next_station
    return if entity_empty?(@trains, "Поездов") || entity_empty?(@routes, "Маршрутов")

    train = choice_validation("номер поезда", @trains, :number)
    train.move_forward
    puts "Поезд #{train.type} №#{train.number} перемещен на следующую станцию: #{train.current_station}."
  end

  def move_previous_station
    return if entity_empty?(@trains, "Поездов") || entity_empty?(@routes, "Маршрутов")

    train = choice_validation("номер поезда", @trains, :number)
    train.move_backward
    puts "Поезд #{train.type} №#{train.number} возвратился на станцию #{train.current_station}."
  end

  def add_train_to_station
    return if entity_empty?(@trains, "Поездов") || entity_empty?(@stations, "Станций")

    station = choice_validation("станцию", @stations, :name)
    train = choice_validation("поезд", @trains, :number)
    station.add_train(train)
    puts "Поезд #{train.type} добавлен на станцию #{station.name}"
  end

  def occupy
    train = choice_validation("поезд", @trains, :number)
    carriage = choice_validation("вагон", train.carriages, :type)

    return (puts "Вагонов нет.") if carriage.nil?

    if carriage.type == :cargo
      occupy_cargo_carriage(carriage)
    elsif carriage.type == :passenger
      occupy_pass_carriage(carriage)
    end
  end

  def occupy_cargo_carriage(carriage)
    vol = ask("Введите объем:").to_i

    if vol > carriage.remaining_volume
      puts "Введено значение превышающее количество свободного.\nСвободно: #{carriage.remaining_volume}"
    else
      carriage.occupy_volume(vol)
      puts "Объем занят.\nОсталось #{carriage.remaining_volume}"
    end
  end

  def occupy_pass_carriage(carriage)
    carriage.take_a_seat
    puts "Место занято.\nОсталось мест: #{carriage.seats_avaliable}"
  end

  def cargo_list
    return if entity_empty?(@trains, "Поездов")

    train = choice_validation("поезд", @trains, :number)
    if train.carriages.empty?
      puts "Вагонов у поезда нет."
    else
      show_cargo_list(train)
    end
  end

  def show_cargo_list(train)
    train.each_carriage do |carriage|
      puts "Тип вагона: #{carriage.type.capitalize}"
      if carriage.type == :cargo
        puts "Объем вагона:#{carriage.volume}\nЗанято:#{carriage.volume_taken} "
      elsif carriage.type == :passenger
        puts "Количество мест: #{carriage.seats}\nЗанято: #{carriage.seats_taken}"
      else
        puts "Неверный выбор!"
      end
    end
  end

  def find_train_by_number
    train_num = ask("Введите номер поезда")
    Train.find(train_num)
  end
end
