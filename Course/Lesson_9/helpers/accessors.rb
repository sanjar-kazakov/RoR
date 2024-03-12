module Accessors
  def self.included(base)
    base.extend ClassMethods
  end


  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        history_var = "@#{var_name}_history"

        define_method(name) { instance_variable_get(var_name) }
        define_method(history_var) { instance_variable_get(history_var) || [] }

        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
          history = instance_variable_get(history_var) || []
          instance_variable_set(history_var, history << value)
        end
      end
    end

    def strong_attr_accessor(name, klass)
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        raise TypeError.new("type is not 'klass'!") unless value.is_a?(klass)

        instance_variable_set(var_name, value)
      end
    end
  end
end
