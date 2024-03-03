require_relative 'train'
require_relative 'carriage'
require_relative 'carriage_cargo'
require_relative 'carriage_pass'
require_relative 'route'
require_relative 'station'
require_relative 'train_cargo'
require_relative 'train_pass'
require 'yaml'



class Main

    attr_accessor :stations, :trains, :routes #:current_station_num, :name
    def initialize
        @questions_data = YAML.safe_load_file('user_actions.yml', symbolize_names: true)[:user_actions]
        @stations = []
        @trains = []
        @routes = []
    end

    def display_questions
        @questions_data.each_with_index do |question, index|
        puts "#{index + 1}. #{question}"
        end
    end

    def dividing_line
        puts  "-" * 30
        puts "Выберите действие, от 1 до 14:"
    end

    def get_choice
        gets.chomp.to_i
    end

    def run
        loop do
            dividing_line
            display_questions
            choice = get_choice
            ask_for_action(choice)
        end
    end

    def ask_for_action(choice)
        case choice
        when 1
            create_station
        when 2
            remove_station
        when 3
            show_stations
        when 4
            create_train
        when 5
            add_carriage
        when 6
            remove_carriage
        when 7
            show_trains
        when 8
            add_train_to_station
        when 9
            train_list
        when 10
            cargo_list
        when 11
            occupy
        when 12
            create_route
        when 13
            display_routes
        when 14
            set_route
        when 15
            add_station
        when 16
            remove_route_station
        when 17
            move_next_station
        when 18
            move_previous_station
        when 19
            find_train_by_number
        when 20
            exit
        end
    end

    private
    # Думаю, что нет смысла быть доступными вне класса этим методам.

    def ask(question)
        puts question
        gets.chomp
    end

    def create_station
        begin
        station_name = ask("Введите название станции:").capitalize
        raise "Название станции обязательно!" if station_name.empty?
        @stations << Station.new(station_name)
        puts "Станция #{station_name} создана!"
        show_stations
        rescue StandardError => e
            puts e
        retry
        end
    end

    def show_stations
        if @stations.empty?
            puts "Пока созданных станций нет."
        else
            puts "Список созданных станций:"
            @stations.each_with_index do |station, index|
            puts "#{index + 1}. #{station.name}"
            end
        end
    end

    def create_train
        begin
            number = ask("Введите номер поезда:")
            raise "Необходимо ввести номер поезда" if number.empty?
            type = ask( "Выберите тип поезда: \n1. Passenger \n2. Cargo").to_i
            case type
            when 1
                @trains << PassTrain.new(number)
            when 2
                @trains << CargoTrain.new(number)
            else
                raise "Невернный номер выбора!"
            end
            puts "Поезд создан!"
        rescue StandardError => e
                puts e
            retry
        end
    end

    def show_trains
        if @trains.empty?
            puts "Поезда не созданы."
        else
            puts "Созданные поезда:"
            @trains.each_with_index do |train, index|
                puts "#{index + 1}. #{train.type.capitalize}, №#{train.number}"
            end
        end
    end

    def create_route
        begin
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
    end

    def save_route(route)
        @routes << route
    end

    def display_routes
        if @routes.empty?
            puts "Созданных маршрутов нет."
        else
            puts "Список созданных маршрутов:"
            @routes.each_with_index do |route, index|
            puts "#{index + 1}. #{route.route_stations.join(' - ')}"
            end
        end
    end

    def add_carriage
        if @trains.empty?
            puts "Поезда не созданы"
        else
        show_trains
            train_index = ask("Выберите поезд:").to_i - 1

            if train_index.between?(0, @trains.size - 1)
                selected_train = @trains[train_index]

            case selected_train.type
            when :passenger
                pass_seats = ask("Введите количество мест в вагоне:").to_i
                pass_carriage = PassCarriage.new(pass_seats)
                selected_train.add_carriage(pass_carriage)
                puts "Вагон добавлен!"
            when :cargo
                cargo_volume = ask("Введите объем вагона:").to_i
                cargo_carriage = CargoCarriage.new(cargo_volume)
                selected_train.add_carriage(cargo_carriage)
                puts "Вагон добавлен!"
            else
                puts "Такого поезда нет"
            end
        end
    end
    end

    def remove_carriage
        show_trains
            train_index = ask("Выберите поезд:").to_i - 1

            if train_index.between?(0, @trains.size - 1)
                selected_train = @trains[train_index]

                if selected_train.carriages.empty?
                    puts "Вагонов у поезда нет"
                elsif
                    selected_train.remove_carriage
                    puts "Вагон отцеплен"
            else
                puts "Такого поезда нет"
            end
        end
    end

    def remove_station
        if @stations.empty?
            puts "Созданных cтанций нет."
        else
            remove_station = ask("Введите станцию, которую необходимо исключить:").capitalize
            station_to_remove = @stations.find {|station| station.name == remove_station }

            if station_to_remove
                @stations.delete(station_to_remove)
                puts "Станция #{remove_station} успешно удалена."
            else
                puts "Такой станции в списке нет."
            end
        end
    end

    def add_station
        begin
        raise "Созданных маршрутов нет. Сначала создайте маршрут." if @routes.empty?
        display_routes
            route_index = ask("Выберите маршрут, к которому хотите добавить промежуточную станцию:").to_i - 1
            if route_index >= 0 && route_index < @routes.size
            route = @routes[route_index]
            int_station = ask("Введите промежуточную станцию маршрута:").capitalize
            raise "Название должно состоять только из латинских букв в количестве не более 10." unless int_station =~ Route::ROUTE_NAME_FORMAT

            route.add_int_station(int_station)
            puts "Промежуточная станция добавлена в маршрут #{route.route_stations.join(' - ')}"
            else
                puts "Некорректный выбор маршрута."
            end
        rescue StandardError => e
            puts e
            retry
        end
    end

    def remove_route_station
        if @routes.empty?
            puts "Созданных маршрутов нет. Сначала создайте маршрут и добавьте промежуточную станцию."
        elsif
            display_routes
            route_index = ask("Выберите маршрут, в котором хотите удалить промежуточную станцию:").to_i - 1

            if route_index >= 0 && route_index < @routes.size
                route = @routes[route_index]
                int_station = ask("Введите промежуточную станцию маршрута:").capitalize

                if route.remove_int_station(int_station)
                    puts "Промежуточная станция удалена из маршрута #{route.route_stations.join(' - ')}"
                else
                    puts "Промежуточная станция не найдена в маршруте."
                end
                else
                    puts "В этом маршруте нет промежуточной станции"
            end
        end
    end

    def set_route
        if @trains.empty? || @routes.empty?
            puts "Поезд или маршрут не создан."
        else
        train = choice_validation("номер поезда", @trains, :number)
        route = choice_validation("маршрут", @routes, :route_stations)

        train.set_route(route)
        puts "Маршрут добавлен поезду: #{train.number}. Поезд на станции #{train.current_station}."
        # require 'pry'; binding.pry
        end
    end

    def move_next_station
        if @trains.empty? || @routes.empty?
            puts "Сначала создайте маршрут и поезд."
        else
            train = choice_validation("номер поезда", @trains, :number)
            train.move_forward
            puts "Поезд #{train.type} №#{train.number} перемещен на следующую станцию: #{train.current_station}."
        end
    end

    def move_previous_station
        if @trains.empty? || @routes.empty?
            puts "Сначала создайте маршрут и поезд."
        else
            train = choice_validation("номер поезда", @trains, :number)
            train.move_backward
            puts "Поезд #{train.type} №#{train.number} возвратился на станцию #{train.current_station}."
        end
    end

    def add_train_to_station
        if @trains.empty? || @stations.empty?
            puts "Станция или поезд не созданы!"
        else
            station = choice_validation("станцию", @stations, :name)
            train = choice_validation("поезд", @trains, :number)
            station.add_train(train)
            puts "Поезд #{train.type} добавлен на станцию #{station.name}"
        end
    end

    # def show_trains_on_the_station
    #     if @stations.empty?
    #         puts "Созданных станций нет"
    #     elsif
    #         show_stations
    #         station_index = ask("Выберите станцию:").to_i - 1

    #         if station_index >= 0 && station_index < @stations.size
    #             @stations.each_with_index do |station, index|
    #                 puts "Станция: #{station.name}\nПоезда: #{station.trains}"
    #             end
    #         end
    #     end
    # end
##### NEW METHODS

    def occupy
        if @trains.empty?
          puts "Поезда не созданы"
        else
          train = choice_validation("поезд", @trains, :number)
          carriage = choice_validation("вагон", train.carriages, :type)

          return (puts "Вагонов нет.") if carriage.nil?

          if carriage.type == :cargo
            vol = ask("Введите объем:").to_i

            if vol > carriage.remaining_volume
              puts "Введено значение превышающее количество свободного.\nСвободно: #{carriage.remaining_volume}"
            else
              carriage.occupy_volume(vol)
              puts "Объем занят.\nОсталось #{carriage.remaining_volume}"
            end
          elsif carriage.type == :passenger
            carriage.take_a_seat
            puts "Место занято.\nОсталось мест: #{carriage.seats_avaliable}"
          end
        end
      end

    def train_list
        if @stations.empty?
            puts "Станции не созданы"
        else
        station = choice_validation("станцию", @stations, :name)
        station.each_train do |train|
            puts "Поезд №: #{train.number}\n Тип: #{train.type}\n Вагоны #{train.carriages}"
        end
        end
    end

    def cargo_list
        if @trains.empty?
            puts "Поезда не созданы"
        else
            train = choice_validation("поезд", @trains, :number)
            train.each_carriage do |carriage|
                puts "Тип вагона: #{carriage.type.capitalize}"
                if carriage.type == :cargo
                    puts "Объем вагона:#{carriage.volume}\nЗанято:#{carriage.volume_taken} "
                elsif
                    carriage.type == :passenger
                    puts "Количество мест: #{carriage.seats}\nЗанято: #{carriage.seats_taken}"
                else
                    puts "Неверный выбор!"
                end
            end
        end
    end
#######
    def choice_validation(title, item, number)
        puts "Выберите #{title}:"
        item.each_with_index {|n, i|
        puts " #{i + 1}. #{(n).send(number)}"}

        index = gets.chomp.to_i - 1
        if index <= 0 && index > item.size
            puts "Неверное число!"
        else
            return item[index]
        end
    end

    def find_train_by_number
        train_num = ask("Введите номер поезда")
        Train.find(train_num)
    end

end

main = Main.new.run
