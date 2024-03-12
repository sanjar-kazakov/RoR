require_relative '../helpers/validation_new'

# route action methods
module RouteActions
  include Validation

  def create_route
    first_station = ask("Ведите начальную станцию:").capitalize
    raise "Начальная станция обязательна!" if first_station.empty?

    last_station = ask("Ведите конечную станцию:").capitalize
    raise "Конечная станция обязательна!" if last_station.empty?

    route = Route.new(first_station, last_station)
    puts "Маршрут #{route.route_stations.join(' - ')} создан!"
    save_route(route)
  rescue StandardError => e
    puts e
    retry
  end

  def save_route(route)
    @routes << route
  end

  def display_routes
    return if entity_empty?(@routes, "Маршрутов")

    puts "Список созданных маршрутов:"
    @routes.each_with_index do |route, index|
      puts "#{index + 1}. #{route.route_stations.join(' - ')}"
    end
  end

  def add_station
    return if entity_empty?(@routes, "Маршрутов")

    display_routes
    route_index, int_station = station_check
    route = @routes[route_index]

    route_check(route, int_station)
  rescue StandardError => e
    puts e
    retry
  end

  def route_check(route, int_station)
    if route.add_int_station(int_station)
      puts "Промежуточная станция добавлена в маршрут #{route.route_stations.join(' - ')}"
    else
      puts "Некорректный выбор маршрута."
    end
  end

  def remove_route_station
    # return if entity_empty?(@routes, "Маршрутов")

    if display_routes
      route_index, int_station = station_check
      route = @routes[route_index]
      if route.remove_int_station(int_station)
        # puts "Промежуточная станция удалена из маршрута #{route.route_stations.join(' - ')}"
      else
        puts "Промежуточная станция не найдена в маршруте."
      end
    else
      puts "В этом маршруте нет промежуточной станции"
    end
  end

  def station_check
    route_index = ask("Выберите маршрут:").to_i - 1
    int_station = ask("Введите промежуточную станцию маршрута:").capitalize

    [route_index, int_station]
  end
end
