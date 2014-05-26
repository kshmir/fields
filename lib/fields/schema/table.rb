module Fields
  class Schema
    class Table
      include Fields::Validations

      def self.from_schema
      end

      def initialize table, options = {}
        @table = table
        @columns = options[:columns] || {}
      end

      def columns
        @columns.clone
      end

      def column_names
        self.columns.keys
      end

      attr_reader :table

      def add_column(name, type, *args)
        assert_symbol(:name, name)
        assert_symbol(:type, type)
        if @columns[name]
          raise ColumnAlreadyExistsError 
        else
          @columns[name] = Schema::Column.new(name, type, *args)
        end
      end

      def == other
        return false unless other.is_a?(Table)
        @table == other.table
      end

      def to_hash
        columns
      end

      alias_method :eql?, :==
    end
  end
end
