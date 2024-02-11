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

    def get_choice
        loop do
            puts  "-" * 30
            puts "Выберите действие, от 1 до 14:"
            display_questions
            choice = gets.chomp.to_i

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
                break
            end
        end
    end

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

    def create_train
        puts "Введите номер поезда:"
        number = gets.chomp
        puts "Введите тип поезда (Passenger; Cargo):"
        type = gets.chomp.capitalize
        puts "Поезд #{type} #{number} создан!"
        if type == "Passenger"
            @trains << PassTrain.new(number, type)
        elsif
            type == "Cargo"
            @trains << CargoTrain.new(number, type)
        end
    end

    # def add_carriage
    #     puts "Введите тип поезда (Passenger; Cargo):"
    #     type = gets.chomp.capitalize

    #     case type
    #         when "Passenger"
    #         @trains.each_with_index {
    #             |train, index| 
    #             puts "Выберите поезд для добавления вагона \n #{index + 1}. #{train.type}, #{train.number};"}
    #             train_index = gets.chomp.to_i - 1

    #         if train_index.between?(0, @trains.size - 1)
    #             pass_carriage = PassCarriage.new(:passenger)
    #             @trains[train_index].add_carriage(pass_carriage)
    #         else
    #             puts "Такого поезда нет"
    #         end

    #         when "Cargo"
    #         @trains.each_with_index {
    #             |train, index| 
    #             puts "Выберите поезд для добавления вагона \n #{index + 1}. #{train.type}, #{train.number};" }
    #             train_index = gets.chomp.to_i - 1
                
    #         if train_index.between?(0, @trains.size - 1)
    #             cargo_carriage = CargoCarriage.new(:cargo)
    #             @trains[train_index].add_carriage(cargo_carriage)
    #         else
    #             puts "Такого типа поезда нет"
    #         end

    #         require 'pry'; binding.pry
    #     end
    # end

    def add_carriage
        
        puts "Выберите поезд:"
        show_trains
        train_index = gets.chomp.to_i - 1
                
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
        
        puts "Выберите поезд:"
        show_trains
        train_index = gets.chomp.to_i - 1
                
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
        puts "Ведите начальную станцию:"
        first_station = gets.chomp.capitalize
        puts "Ведите конечную станцию:"
        last_station = gets.chomp.capitalize

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
                puts "Введите станцию, которую необходимо исключить:"
                remove_station = gets.chomp.capitalize

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
            puts "Выберите маршрут, к которому хотите добавить промежуточную станцию:"
            route_index = gets.chomp.to_i - 1
    
            if route_index >= 0 && route_index < @routes.size
                route = @routes[route_index]
                puts "Введите промежуточную станцию маршрута:"
                int_station = gets.chomp.capitalize
        
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
            puts "Выберите маршрут, в котором хотите удалить промежуточную станцию:"
            route_index = gets.chomp.to_i - 1

            if (route_index >= 0 && route_index < @routes.size)
                route = @routes[route_index]
                puts "Введите промежуточную станцию маршрута:"
                int_station = gets.chomp.capitalize

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
            show_trains
            puts "Выберите поезд:"
            trains_index = gets.chomp.to_i - 1

            if trains_index >= 0 && trains_index < @trains.size
                puts "Выберите маршрут для поезда:"
                display_routes
                route_index = gets.chomp.to_i - 1

                if route_index >= 0 && route_index < @routes.size
                    route = @routes[route_index]
                    train = @trains[trains_index]

                    train.set_route(route)
                    puts "Маршрут добавлен поезду: #{train.number}"
            else
                puts "Некорректный выбор маршрута"  
            end   
            else
                puts "Некорректный выбор поезда"
            end
        end
    end

    def move_next_station
        if (@trains && @routes).empty?
            puts "Сначала создайте маршрут и поезд."
        elsif
            display_routes
            puts "Выберите маршрут:"
            route_index = gets.chomp.to_i - 1
    
            if route_index >= 0 && route_index < @routes.size
                puts "Выберите поезд:"
                @trains.each_with_index { 
                    |train, index| 
                    puts "#{index + 1}. #{train.type} #{train.number}" }
            end
                train_index = gets.chomp.to_i - 1
                selected_train = @trains[train_index]
                
            if train_index.between?(0, @trains.size - 1) && selected_train.route
                
                selected_train.move_forward
                puts "Поезд перемещен на следующую станцию: #{selected_train.current_station}."
                # require 'pry'; binding.pry
                
            end
        end
    end

    def move_previous_station
        if (@trains && @routes).empty?
            puts "Сначала создайте маршрут и поезд."
        elsif
            display_routes
            puts "Выберите маршрут:"
            route_index = gets.chomp.to_i - 1
    
            if route_index >= 0 && route_index < @routes.size
                puts "Выберите поезд:"
                @trains.each_with_index { 
                    |train, index| 
                    puts "#{index + 1}. #{train.type} #{train.number}" }
            end
                train_index = gets.chomp.to_i - 1
                selected_train = @trains[train_index]

            if train_index.between?(0, @trains.size - 1) && selected_train.route

                selected_train.move_backward
                puts "Поезд перемещен на предыдущую станцию #{selected_train.current_station}."
            end
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

end
main = Main.new
main.get_choice
