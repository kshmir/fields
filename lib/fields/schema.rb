module Fields
  class Schema
    def initialize opts = {}
      @tables = {}
    end

    def tables
      @tables.clone
    end

    def add_column table, name, type, opts = {}
      validate_table(table)
      assert_symbol(:name, name)
      assert_symbol(:type, type)
      assert_not_nil(:table, @tables[table])
      @tables[table][name] = type
    end

    def add_table table
      validate_table(table)
      @tables[table] = {}
    end

    private
    def assert_not_nil(key, value)
      if value.nil?
        raise "Expected #{key} not to be nil"
      end
    end

    def assert_symbol(key, value)
      unless value.is_a?(Symbol)
        raise "Expected #{key} to be a symbol"
      end
    end

    def validate_table(table)
      unless valid_table?(table)
        raise "Invalid table, expected non-empty string or symbol for name"
      end
    end
    def valid_table?(table)
      ( table.is_a?(String) && !table.empty? ) ||
        table.is_a?(Symbol)
    end
  end
end
