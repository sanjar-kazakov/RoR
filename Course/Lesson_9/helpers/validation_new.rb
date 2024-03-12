module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  module ClassMethods
    def validate(name, type, *args)
      validations << { name: name, type: type, args: args }
    end

    def validations
      @validations ||= []
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |value|
        send("validate_#{value[:type]}", value[:name], value[:args])
      end
    end
  end

  def validate_presence(name, arg)
    value = instance_variable_get("@#{name}")
    raise "#{name} не может быть nil или пустым." if value.nil? || value.empty?
  end

  def validate_format(name, arg)
    value = instance_variable_get("@#{name}")
    raise "Неверный формат" if value !~ arg[0]
  end

  def validate_type(name, arg)
    value = instance_variable_get("@#{name}")
    raise "Неверный тип!" if value !is_a?(String)
  end

  def entity_empty?(entity, message)
    if entity.empty?
      puts "#{message} нет."
      return true
    end
    false
  end
end
