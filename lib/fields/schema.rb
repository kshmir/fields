require 'fields/validations'
require 'fields/schema/table'
require 'fields/schema/column'

module Fields
  class Schema
    include Fields::Validations

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
      table = @tables[table]
      table.add_column(name, type, opts)
    end

    def add_table table
      validate_table(table)
      @tables[table] = Table.new(table)
    end
  end
end
