require_relative 'train/train'
require_relative 'train/actions'
require_relative 'train/carriage'
require_relative 'train/carriage_cargo'
require_relative 'train/carriage_pass'
require_relative 'route/route'
require_relative 'route/actions'
require_relative 'stations/station'
require_relative 'stations/actions'
require_relative 'train/train_cargo'
require_relative 'train/train_pass'
require_relative 'helpers/user_actions'
require 'yaml'

# Engine
class Main
  include UserActions
  include StationActions
  include TrainActions
  include RouteActions

  attr_accessor :stations, :trains, :routes

  def initialize
    @questions_data = YAML.safe_load_file('helpers/user_choice.yml', symbolize_names: true)[:user_choice]
    @stations = []
    @trains = []
    @routes = []
  end

  def run
    loop do
      dividing_line
      display_questions
      choice = make_choice
      ask_for_action(choice)
    end
  end

  def dividing_line
    puts "-" * 30
    puts "Выберите действие:"
  end

  def display_questions
    @questions_data.each_with_index do |question, index|
      puts "#{index + 1}. #{question}"
    end
  end
end

Main.new.run
