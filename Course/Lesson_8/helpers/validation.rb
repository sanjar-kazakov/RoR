# validation module
module Validation
  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def validate!
    case self
    when Train
      train_validation
    when Route
      route_validation
    when Station
      station_validation
    end
  end

  def train_validation
    raise "Неверный формат номера поезда!" if number !~ Train::NUMBER_FORMAT
  end

  def route_validation
    raise "Неверное название!" if route_stations.all? { |stations| stations !~ Route::ROUTE_NAME_FORMAT }
  end

  def station_validation
    raise "Название должно состоять только из латинских букв." if name !~ Station::NAME_FORMAT
    raise "Название должно состоять из не более 10 букв." if name.length > 10
  end

  def entity_empty?(entity, message)
    if entity.empty?
      puts "#{message} нет."
      return true
    end
    false
  end
end
