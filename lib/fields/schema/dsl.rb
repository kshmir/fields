module Fields
  class Schema
    class Dsl
      def initialize(table)
        @table = table
      end

      def __field__(name, type, *args)
        @table.add_column(name, type, *args)
      end

      def method_missing(name, *args)
        __field__(name, args.first, *args[1..-1])
      end
    end
  end
end
