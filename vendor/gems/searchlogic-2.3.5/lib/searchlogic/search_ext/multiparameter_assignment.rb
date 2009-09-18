module Searchlogic
  module SearchExt
    # Contains extensions to Searchlogic::Search which lets it properly handle conditions
    # passed in using ActiveRecord's multiparameter-style
    module MultiParameterAssignment
      
      def self.included(parent)
        parent.class_eval do
          alias_method_chain :conditions=, :multiple_parameters
        end
      end
      
      # Normalizes all multiparameter conditions to be either a date or time instance
      # when passed on to the original conditions= call. This means that datetime_select
      # and it's siblings all work as expected.
      def conditions_with_multiple_parameters=(conditions)
        self.conditions_without_multiple_parameters = normalize_conditions(conditions)
      end
      
      def normalize_conditions(input_conditions)
        conditions = {}
        multiparameter_conditions = {}
        # ActiveRecord::Base determines that an attribute with ( in the name is to be considered
        # multiparameter. We simply seperate them out to process non-multiparameter items seperately.
        input_conditions.stringify_keys.each_pair do |k, v|
          if k.include?("(")
            multiparameter_conditions[k] = v
          else
            conditions[k] = v
          end
        end
        if multiparameter_conditions.present?
          conditions.merge!(normalized_multiparameter_conditions(multiparameter_conditions))
        end
        conditions
      end
      
      protected
      
      def normalized_multiparameter_conditions(conditions)
        argument_mapping = extract_multiparameter_arguments(conditions)
        conditions = {}
        argument_mapping.each_pair do |attribute, arguments|
          if arguments.length == 1
            conditions[attribute] = arguments[0]
            next
          end
          field_type = cast_type(normalize_scope_name(attribute))
          case field_type
          when :time, :datetime
            conditions[attribute] = cast_multiparameter_time(*argument_array(arguments, 5))
          when :date
            conditions[attribute] = cast_multiparameter_date(*argument_array(arguments, 3))
          else
            raise NotImplementedError, "#{field_type} is not currently supported for multiparameter assignment"
          end
        end
        conditions
      end

      def extract_multiparameter_arguments(conditions)
        argument_mapping = Hash.new { |h,k| h[k] = [] }
        conditions.each_pair do |key, value|
          name, options = key.split("(", 2)
          position, modifier = options[0,2].split("")
          if ["i", "f"].include? modifier
            argument_mapping[name][position.to_i - 1] = value.send("to_#{modifier}")
          end
        end
        argument_mapping
      end
      
      def cast_multiparameter_time(y, m, d, h = 0, min = 0)
        Time.zone.local(y, m, d, h, min)
      end
      
      def cast_multiparameter_date(y, m, d)
        Date.new(y, m, d)
      rescue ArgumentError
        cast_multiparameter_time(y, m, d).to_date
      end
      
      def argument_array(array, length)
        new_array = [0] * length
        array.each_with_index { |value, index|  new_array[index] = value if value }
        new_array
      end
      
    end
  end
end