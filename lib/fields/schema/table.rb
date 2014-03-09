module Fields
  class Schema
    class Table
      include Fields::Validations

      def initialize table
        @table = table
        @columns = {}
      end

      def add_column(name, type, opts = {})
        assert_symbol(:name, name)
        assert_symbol(:type, type)
        @columns[:name] = Schema::Column.new(name, type, opts)
      end
    end
  end
end
