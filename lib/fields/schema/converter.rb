module Fields
  class Schema
    class Converter
      include Fields::Validations

      def from obj
        if is_a_connection?(obj)
          obj = active_record_to_hash(obj)
        end
        hash_to_schema(obj)
      end

      def to_migration schema
      end

      private

      def is_a_connection? obj
        obj.is_a?(ActiveRecord::ConnectionAdapters::AbstractAdapter)
      end

      def hash_to_schema hash
        schema = Fields::Schema.new
        hash.keys.each do |table|
          schema.add_table table
          hash[table].each do |column|
            schema.add_column(table, column[:name].to_sym, column[:type].to_sym, column.clone)
          end
        end
        schema
      end

      def active_record_to_hash connection
        hash = HashWithIndifferentAccess.new
        tables = connection.tables - ["schema_info"]
        tables.each do |table|
          hash[table.to_sym] = columns_to_hash(connection.columns(table))
        end
        hash
      end

      def columns_to_hash columns
        columns.map do |column|
          {
              coder:       column.coder,
              default:     column.default,
              limit:       column.limit,
              name:        column.name,
              null:        column.null,
              precision:   column.precision,
              primary:     column.primary,
              scale:       column.scale,
              sql_type:    column.sql_type,
              type:        column.type
          }
        end
      end
    end
  end
end
