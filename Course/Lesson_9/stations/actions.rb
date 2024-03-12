require_relative '../helpers/validation_new'

# route action methods
module StationActions
  include Validation

  def create_station
    station_name = ask("Введите название станции:").capitalize
    raise "Название станции обязательно!" if station_name.empty?

    @stations << Station.new(station_name)
    puts "Станция #{station_name} создана!"
    show_stations
  rescue StandardError => e
    puts e
    retry
  end

  def remove_station
    return if entity_empty?(@stations, "Станций")

    remove_station = ask("Введите станцию, которую необходимо исключить:").capitalize
    station_to_remove = @stations.find { |station| station.name == remove_station }

    if station_to_remove
      @stations.delete(station_to_remove)
      puts "Станция #{remove_station} успешно удалена."
    else
      puts "Такой станции в списке нет."
    end
  end

  def show_stations
    return if entity_empty?(@stations, "Станций")

    puts "Список созданных станций:"
    @stations.each_with_index do |station, index|
      puts "#{index + 1}. #{station.name}"
    end
  end

  def train_list
    return if entity_empty?(@stations, "Станций")

    station = choice_validation("станцию", @stations, :name)
    if station.trains.empty?
      puts "Поездов на станции нет."
    else
      station.each_train { |train| puts "Поезд №: #{train.number}\n Тип: #{train.type}" }
    end
  end
end
