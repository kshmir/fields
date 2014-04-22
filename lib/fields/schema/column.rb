module Fields
  class Schema
    class Column
      include Fields::Validations

      def initialize name, type, *args
        @name = name
        @type = type
        @extra_params = args
      end

      attr_reader :name, :type, :extra_params

      def == other
        return false unless other.is_a?(Column)

        @name == other.name &&
          @type == other.type &&
          @extra_params == other.extra_params
      end

      alias_method :eql?, :==
    end
  end
end
