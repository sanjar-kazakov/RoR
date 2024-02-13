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

    attr_accessor :stations, :trains, :routes, :current_station_num, :name
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
            show_trains
        when 6
            create_route
        when 7
            display_routes
        when 8
            add_station
        when 9
            remove_route_station
        when 10
            set_route
        when 11
            move_next_station
        when 12
            move_previous_station  
        when 13
            show_trains_on_the_station
        when 14
            add_carriage
        when 15
            remove_carriage
        when 16
            exit
        end
    end

    private
    # Думаю, что нет смысла быть доступными вне класса этим методам.

    def create_station
        puts "Введите название станции:"
        station_name = gets.chomp.capitalize
        @stations << Station.new(station_name)
        puts "Станция #{station_name} создана!"
        show_stations
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

    def ask(question)
        puts question
        gets.chomp
    end

    def create_train
        number = ask("Введите номер поезда:")
        type = ask( "Введите тип поезда (Passenger; Cargo):").capitalize

        puts "Поезд #{type} #{number} создан!"
        if type == "Passenger"
            @trains << PassTrain.new(number, type)
        elsif
            type == "Cargo"
            @trains << CargoTrain.new(number, type)
        end
        # require 'pry'; binding.pry
    end

    def add_carriage 
        show_trains
            train_index = ask("Выберите поезд:").to_i - 1
                
            if train_index.between?(0, @trains.size - 1)
                selected_train = @trains[train_index]

            case selected_train.type 
            when "Passenger"
                pass_carriage = PassCarriage.new(:passenger)
                selected_train.add_carriage(pass_carriage)
                puts "Вагон добавлен!"

            when "Cargo"
                cargo_carriage = CargoCarriage.new(:cargo)
                selected_train.add_carriage(cargo_carriage)
                puts "Вагон добавлен!"
            else
                puts "Такого поезда нет"
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

    def show_trains
        if @trains.empty?
            puts "Поезда не созданы."
        else
            puts "Созданные поезда:"
            @trains.each_with_index do |train, index|
                puts "#{index + 1}. #{train.type}, №#{train.number}"
            end  
        end
    end

    def create_route
        first_station = ask("Ведите начальную станцию:").capitalize
        last_station = ask("Ведите конечную станцию:").capitalize

        route = Route.new(first_station, last_station)
        puts "Маршрут #{route.route_stations.join(' - ')} создан!"

        save_route(route)
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
        if @routes.empty?
            puts "Созданных маршрутов нет. Сначала создайте маршрут."
        elsif
            display_routes
            route_index = ask("Выберите маршрут, к которому хотите добавить промежуточную станцию:").to_i - 1
    
            if route_index >= 0 && route_index < @routes.size
                route = @routes[route_index]
                int_station = ask("Введите промежуточную станцию маршрута:").capitalize
        
                route.add_int_station(int_station)
                puts "Промежуточная станция добавлена в маршрут #{route.route_stations.join(' - ')}"
            end
        else
            puts "Некорректный выбор маршрута."
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
        train = validation("номер поезда", @trains, :number)
        route = validation("маршрут", @routes, :route_stations)

        train.set_route(route)
        puts "Маршрут добавлен поезду: #{train.number}. Поезд на станции #{train.current_station}."
        # require 'pry'; binding.pry
        end
    end

    def move_next_station
        if @trains.empty? || @routes.empty?
            puts "Сначала создайте маршрут и поезд."
        else
            train = validation("номер поезда", @trains, :number)
            train.move_forward
            puts "Поезд #{train.type} №#{train.number} перемещен на следующую станцию: #{train.current_station}."
        end
    end

    def move_previous_station
        if @trains.empty? || @routes.empty?
            puts "Сначала создайте маршрут и поезд."
        else
            train = validation("номер поезда", @trains, :number)
            train.move_backward
            puts "Поезд #{train.type} №#{train.number} возвратился на станцию #{train.current_station}."
        end
    end

    def show_trains_on_the_station

        if @stations.empty?
            puts "Созданных станций нет"
        elsif
            show_stations
            puts "Выберите станцию:"
            station_index = gets.chomp.to_i - 1

            if station_index >= 0 && station_index < @stations.size
                @stations.each_with_index do |station, index|
                    puts "Станция: #{station.name}; Поезда: #{station.trains}"
                end
            end
        end
    end

    def validation(title, item, number)

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


end

main = Main.new.run
